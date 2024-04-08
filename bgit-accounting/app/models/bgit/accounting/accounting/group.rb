module Bgit
  module Accounting
    module Accounting
      class Group < Keepr::Group
        include Bgit::Accounting::Model::KeeprGroupExtensionsConcern

        self.inheritance_column = :_
      end
    end
  end
end
