module Bgit
  module Accounting
    module Banking
      class ImportN26StatementsService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :parsed_csv, :credit_transfers, :debit_transfers, :bank_accounts, :journals

          def transfers
            @transfers ||= credit_transfers + debit_transfers
          end
        end

        attr_accessor :csv_file, :csv_data, :account, :account_id

        validates :csv_data, presence: true
        validates :account, presence: true
        validates :bank_1800, presence: true
        validates :unassigned_133710, presence: true
        validates :unassigned_133720, presence: true

        private

        def _perform
          @result.credit_transfers = []
          @result.debit_transfers = []
          @result.bank_accounts = []
          @result.journals = []

          @result.parsed_csv = parse_csv!
          process_parsed_csv!
        end

        def save
          ActiveRecord::Base.transaction do
            @result.journals.map(&:save!)
            @result.transfers.each do |t|
              t.save!
            rescue => e
              binding.pry
            end
          end
        end

        def account
          @account ||= Bgit::Accounting::Banking::Account.find_by(id: account_id)
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
              transfer = process_credit(row)
              @result.credit_transfers << transfer
              transfer.journal = build_incoming_journal(row, transfer)
            when "Lastschrift", "Überweisung"
              transfer = process_debit(row)
              @result.debit_transfers << transfer
              transfer.journal = build_outgoing_journal(row, transfer)
            else
              raise "Unknown transaction type: #{row["Transaktionstyp"]}"
            end
          end
        end

        def bank_1800
          @bank_1800 ||= Bgit::Accounting::Accounting::Account.find_by(number: "1800")
        end

        def unassigned_133710
          @unassigned_133710 ||= Bgit::Accounting::Accounting::Account.find_by(number: "133710")
        end

        def unassigned_133720
          @unassigned_133710 ||= Bgit::Accounting::Accounting::Account.find_by(number: "133720")
        end

        def transaction_costs_6855
          @transaction_costs_6855 ||= Bgit::Accounting::Accounting::Account.find_by(number: "6855")
        end

        def build_incoming_journal(row, transfer)
          debit = Bgit::Accounting::Accounting::Posting.new(side: "debit", keepr_account: bank_1800, amount: row["Betrag (EUR)"].to_f.abs)
          credit = Bgit::Accounting::Accounting::Posting.new(side: "credit", keepr_account: unassigned_133710, amount: row["Betrag (EUR)"].to_f.abs)
          Bgit::Accounting::Accounting::Journal.new.tap do |j|
            j.keepr_postings = [debit, credit]
            j.date = row["Datum"]
            j.subject = row["Verwendungszweck"]
            @result.journals << j
          end
        end

        def build_outgoing_journal(row, transfer, debit_account: unassigned_133720)
          debit = Bgit::Accounting::Accounting::Posting.new(side: "debit", keepr_account: debit_account, amount: row["Betrag (EUR)"].to_f.abs)
          credit = Bgit::Accounting::Accounting::Posting.new(side: "credit", keepr_account: bank_1800, amount: row["Betrag (EUR)"].to_f.abs)
          Bgit::Accounting::Accounting::Journal.new.tap do |j|
            j.keepr_postings = [debit, credit]
            j.date = row["Datum"]
            j.subject = row["Verwendungszweck"]
            @result.journals << j
          end
        end

        def process_account_management_fee(row)
          row["Kontonummer"] = "DE69123456789012345678"
          transfer = process_debit(row)
          @result.debit_transfers << transfer
          transfer.journal = build_outgoing_journal(row, transfer, debit_account: transaction_costs_6855)
        end

        def process_credit(row)
          # find or initialize sender account
          sender_account = @result.bank_accounts.find { |ba| ba.iban == row["Kontonummer"] } || Bgit::Accounting::Banking::Account.find_or_initialize_by(iban: row["Kontonummer"]) do |ba|
            ba.owner = row["Empfänger"]
            ba.name = "Bank-Konto"
            @result.bank_accounts << ba
          end
          # target account is the account
          target_account = account
          # build transfer
          Bgit::Accounting::Banking::Transfer.new(
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
          target_account = @result.bank_accounts.find { |ba| ba.iban == row["Kontonummer"] } || Bgit::Accounting::Banking::Account.find_or_initialize_by(iban: row["Kontonummer"]) do |ba|
            ba.owner = row["Empfänger"]
            ba.name = "Bank-Konto"
            @result.bank_accounts << ba
          end
          # build transfer
          Bgit::Accounting::Banking::Transfer.new(
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
end
