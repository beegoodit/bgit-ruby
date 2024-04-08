module Bgit
  module Accounting
    module Accounting
      class Account < Keepr::Account
        include Bgit::Accounting::Model::KeeprAccountExtensionsConcern

        self.inheritance_column = :_
        # self.table_name = "keepr_accounts"
      end
    end
  end
end
