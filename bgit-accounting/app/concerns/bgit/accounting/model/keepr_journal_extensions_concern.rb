module Bgit
  module Accounting
    module Model
      module KeeprJournalExtensionsConcern
        extend ActiveSupport::Concern

        included do
          has_one :bank_transfer, class_name: "Bgit::Accounting::Banking::Transfer", dependent: :nullify
          has_one :voucher, class_name: "Bgit::Accounting::Vouchers::Voucher", dependent: :nullify
        end

        def human
          "#{debit_postings.map(&:keepr_account).map(&:number).join(", ")} - #{amount} -> #{credit_postings.map(&:keepr_account).map(&:number).join(", ")}"
        end
      end
    end
  end
end
