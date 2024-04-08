module Bgit
  module Accounting
    module Accounting
      class CostCenter < Keepr::CostCenter
        include Bgit::Accounting::Model::KeeprCostCenterExtensionsConcern

        self.inheritance_column = :_
      end
    end
  end
end
