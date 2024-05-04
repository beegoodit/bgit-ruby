module Bgit
  module Accounting
    module Accounting
      # Beispiele:
      #
      # Bank belastet Kontoführungsgebühren
      #
      # 6855 Nebenkosten des Geldverkehrs -> 1800 Bank
      #
      # Mitglied zahlt Mitgliedsbeitrag
      #
      # 1800 Bank -> 1200 Forderungen aus Lieferungen und Leistungen
      #
      # Verein fordert Mitgliedsbeitrag
      #
      # 1200 Forderungen aus Lieferungen und Leistungen -> 4000 Echte Mitgliedsbeiträge
      #
      class Journal < Keepr::Journal
        include Bgit::Accounting::Model::KeeprJournalExtensionsConcern

        self.inheritance_column = :_
      end
    end
  end
end
