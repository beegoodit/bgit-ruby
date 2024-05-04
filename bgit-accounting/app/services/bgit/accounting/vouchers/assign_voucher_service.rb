module Bgit
  module Accounting
    module Vouchers
      class AssignVoucherService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :voucher, :journal, :postings, :creditor_posting
        end

        attr_accessor :contact_id,
          :creditor_account_id,
          :debtor_account_id,
          :due_date,
          :issue_date,
          :kind,
          :note,
          :number,
          :voucher_id,
          :postings

        validates :kind,
          :voucher,
          :issue_date,
          :number, presence: true

        def creditor_account_id
          @creditor_account_id ||= voucher&.postings&.credits&.first&.keepr_account_id
        end

        def debtor_account_id
          @debtor_account_id ||= voucher&.postings&.debits&.first&.keepr_account_id
        end

        def voucher
          @voucher ||= Voucher.find_by(id: @voucher_id)
        end

        def issue_date
          @issue_date ||= voucher&.issue_date
        end

        def due_date
          @due_date ||= voucher&.due_date
        end

        def kind
          @kind ||= voucher&.kind
        end

        def number
          @number ||= voucher&.number
        end

        def postings=(value)
          @postings = case value
          when Array
            value.collect do |v|
              v.is_a?(Hash) ? Bgit::Accounting::Accounting::Posting.new(v) : v
            end
          else
            value
          end
        end

        def accountable
          @accountable ||= voucher&.accountable
        end

        private

        def _perform
          @result.voucher = voucher
          @result.journal = build_journal
          assign_voucher_attributes
          assign_postings
          assign_journal_to_voucher
          @result.postings = postings
          if @result.voucher.kind == "purchase_invoice"
            @result.creditor_posting = build_creditor_posting
          end
          if @result.voucher.kind == "sales_invoice"
            @result.debtor_posting = build_debtor_posting
          end
          unless @result.voucher.valid?
            add_error_and_say(:base, voucher.errors.full_messages.join(", "))
          end
          unless @result.journal.valid?
            add_error_and_say(:base, @result.journal.errors.full_messages.join(", "))
          end
          unless @result.postings.all?(&:valid?)
            add_error_and_say(:base, postings.map { |a| a.errors.full_messages.join(", ") }.join(", "))
          end
          @result.voucher = voucher
        end

        def build_journal
          Bgit::Accounting::Accounting::Journal.new(
            date: issue_date,
            accountable: voucher.owner
          )
        end

        def assign_journal_to_voucher
          say "Assigning journal to voucher" do
            voucher.keepr_journal = @result.journal
          end
        end

        def assign_postings
          say "Assigning #{postings.size} postings" do
            postings.each do |posting|
              posting.keepr_journal = @result.journal
            end
          end
        end

        def build_creditor_posting
          say "Building temporary posting for purchase invoice" do
            total_amount = postings.sum(&:amount)
            Bgit::Accounting::Accounting::Posting.new(
              keepr_account_id: Bgit::Accounting::Accounting::Account.find_by(number: "133710").id,
              amount: postings.sum(&:amount),
              side: "credit",
              keepr_journal: @result.journal
            )
          end
        end

        def build_debtor_posting
          say "Building debtor posting for sales invoice" do
            total_amount = postings.sum(&:amount)
            Bgit::Accounting::Accounting::Posting.new(
              keepr_account_id: Bgit::Accounting::Accounting::Account.find_by(number: "133720").id,
              amount: postings.sum(&:amount),
              side: "debit",
              keepr_journal: @result.journal
            )
          end
        end

        def assign_voucher_attributes
          voucher.assign_attributes(
            note: note,
            due_date: due_date,
            issue_date: issue_date,
            number: number,
            kind: kind
          )
        end

        def save
          ActiveRecord::Base.transaction do
            voucher.save!
            postings.map(&:save!)
          end
        end
      end
    end
  end
end
