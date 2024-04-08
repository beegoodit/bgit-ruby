module Bgit
  module Accounting
    module Accounting
      class Tax < Keepr::Tax
        include Bgit::Accounting::Model::KeeprTaxExtensionsConcern

        self.inheritance_column = :_
      end
    end
  end
end
