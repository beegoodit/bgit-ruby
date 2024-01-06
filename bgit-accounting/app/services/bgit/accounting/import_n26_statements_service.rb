module Bgit
  module Accounting
    class ImportN26StatementsService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :parsed_csv, :credit_transfers, :debit_transfers, :bank_accounts

        def transfers
          @transfers ||= credit_transfers + debit_transfers
        end
      end

      attr_accessor :csv_file, :csv_data, :account, :account_id

      validates :csv_data, presence: true
      validates :account, presence: true

      private

      def _perform
        @result.credit_transfers = []
        @result.debit_transfers = []
        @result.bank_accounts = []

        @result.parsed_csv = parse_csv!
        process_parsed_csv!
      end

      def save
        ActiveRecord::Base.transaction do
          @result.transfers.each do |t|
            t.save!
          rescue => e
            binding.pry
          end
        end
      end

      def account
        @account ||= Bgit::Accounting::BankAccount.find_by(id: account_id)
      end

      def csv_data
        @csv_data ||= File.read(csv_file)
      end

      def parse_csv!
        CSV.parse(csv_data, headers: true, col_sep: ",")
      end

      def process_parsed_csv!
        @result.parsed_csv.each do |row|
          process_row!(row)
        end
      end

      # "Datum","Empfänger","Kontonummer","Transaktionstyp","Verwendungszweck","Betrag (EUR)","Betrag (Fremdwährung)","Fremdwährung","Wechselkurs"
      # "2020-01-28","ROBERTO VASQUEZ ANGEL","DE09500100600175890604","Gutschrift","Roberto Vasquez Angel, MB 2020","60.0","","",""
      def process_row!(row)
        say "Processing row: #{row.to_h}" do
          if row["Kontonummer"].blank? && row["Empfänger"] == "N26"
            process_account_management_fee(row)
            next
          end
          case row["Transaktionstyp"]
          when "Gutschrift"
            process_credit(row)
          when "Lastschrift", "Überweisung"
            process_debit(row)
          else
            raise "Unknown transaction type: #{row["Transaktionstyp"]}"
          end
        end
      end

      def process_account_management_fee(row)
        row["Kontonummer"] = "DE69123456789012345678"
        process_debit(row)
      end

      def process_credit(row)
        # find or initialize sender account
        sender_account = @result.bank_accounts.find { |ba| ba.iban == row["Kontonummer"] } || Bgit::Accounting::BankAccount.find_or_initialize_by(iban: row["Kontonummer"]) do |ba|
          ba.owner = row["Empfänger"]
          ba.name = "Bank-Konto"
          @result.bank_accounts << ba
        end
        # target account is the account
        target_account = account
        # build transfer
        @result.credit_transfers << Bgit::Accounting::Transfer.new(
          sender_bank_account: sender_account,
          recipient_bank_account: target_account,
          amount: row["Betrag (EUR)"].to_f,
          purpose: row["Verwendungszweck"],
          value_at: row["Datum"]
        )
      end

      def process_debit(row)
        # sender account is the account
        sender_account = account
        # find or initialize target account
        target_account = @result.bank_accounts.find { |ba| ba.iban == row["Kontonummer"] } || Bgit::Accounting::BankAccount.find_or_initialize_by(iban: row["Kontonummer"]) do |ba|
          ba.owner = row["Empfänger"]
          ba.name = "Bank-Konto"
          @result.bank_accounts << ba
        end
        # build transfer
        @result.debit_transfers << Bgit::Accounting::Transfer.new(
          sender_bank_account: sender_account,
          recipient_bank_account: target_account,
          amount: row["Betrag (EUR)"].to_f,
          purpose: row["Verwendungszweck"],
          value_at: row["Datum"]
        )
      end
    end
  end
end
