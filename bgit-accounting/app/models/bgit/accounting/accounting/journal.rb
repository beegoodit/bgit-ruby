module Bgit
  module Accounting
    module Accounting
      class Journal < Keepr::Journal
        include Bgit::Accounting::Model::KeeprJournalExtensionsConcern

        self.inheritance_column = :_
      end
    end
  end
end
