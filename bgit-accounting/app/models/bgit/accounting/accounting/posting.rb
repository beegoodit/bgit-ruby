module Bgit
  module Accounting
    module Accounting
      class Posting < Keepr::Posting
        include Bgit::Accounting::Model::KeeprPostingExtensionsConcern

        self.inheritance_column = :_
      end
    end
  end
end
