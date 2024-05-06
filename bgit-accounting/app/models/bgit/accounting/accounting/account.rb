module Bgit
  module Accounting
    module Accounting
      class Account < Keepr::Account
        self.inheritance_column = :_

        scope :assets, -> { where(kind: "asset") }
        scope :creditors, -> { where(kind: "creditor") }
        scope :debtors, -> { where(kind: "debtor") }
        scope :expenses, -> { where(kind: "expense") }
        scope :forwards, -> { where(kind: "forward") }
        scope :liabilities, -> { where(kind: "liability") }
        scope :revenues, -> { where(kind: "revenue") }

        def human
          "#{number} (#{human_value_name(:kind_symbol)}) #{name}"
        end
      end
    end
  end
end
