module Bgit
  module Accounting
    class SeedService < JsonSeeds::SeedService::Base
      class Result < JsonSeeds::SeedService::Result::Base
      end

      attr_accessor :accountables

      validates :accountables, presence: true

      private

      def _perform
        ensure_default_chart
        ensure_default_account_categories
        accountables.each do |accountable|
          ensure_default_chart_for_accountable(accountable)
          ensure_default_expense_accounts_for(accountable)
          ensure_default_income_accounts_for(accountable)
        end
      end

      def ensure_default_chart_for_accountable(accountable)
        if Bgit::Accounting::Accounting::AccountableChart.where(accountable: accountable).exists?
          say "Default chart for #{accountable.human} already exists"
          return
        end
        say "Building default chart for #{accountable.human}" do
          Bgit::Accounting::Accounting::AccountableChart.create!(accountable: accountable, chart: @default_chart)
        end
      end

      def ensure_default_chart
        say "Building default chart" do
          @default_chart = Bgit::Accounting::Accounting::Chart.where(identifier: "SKR42", label: "Standardkontenrahmen 42 (Vereine)").first_or_create!
        end
      end

      def ensure_default_account_categories
        say "Building default account categories" do
          @default_account_categories = [
            {identifier: "goods_expense", label: "Warenaufwand", side: :expense},
            {identifier: "service_expense", label: "Dienstleistungsaufwand", side: :expense},
            {identifier: "wages_and_salaries_expense", label: "Lohn- und Gehaltsaufwand", side: :expense},
            {identifier: "depreciation_expense", label: "Abschreibungen und Aufwendungen für Wertminderungen", side: :expense},
            {identifier: "other_operating_expenses", label: "Sonstige betriebliche Aufwendungen", side: :expense},

            {identifier: "membership_fees_and_donations_income", label: "Mitgliederbeiträge und Spenden", side: :income},
            {identifier: "sales_income", label: "Erlöse", side: :income},
            {identifier: "inventory_changes_income", label: "Bestandsveränderungen", side: :income},
            {identifier: "other_operating_income", label: "Sonstige betriebliche Erträge", side: :income}
          ].each_with_object({}) do |attrs, hash|
            hash[attrs[:identifier]] = Bgit::Accounting::Accounting::AccountCategory.where(attrs.merge(chart_id: @default_chart.id)).first_or_create!
          end
        end
      end

      def ensure_default_income_accounts_for(accountable)
        say "Building default income accounts for #{accountable.human}" do
          # Mitgliederbeiträge und Spenden
          [
            {account_number: "40000", label: "Echte Mitgliedsbeiträge"},
            {account_number: "40100", label: "Aufnahmegebühren"},
            {account_number: "40400", label: "Erträge aus Spenden/Zuwendungen"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["membership_fees_and_donations_income"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end

          # Erlöse
          [
            {account_number: "42000", label: "Erlöse"},
            {account_number: "42010", label: "Erlöse aus Eintrittsgeldern"},
            {account_number: "42030", label: "Erlöse aus Teilnehmer-/Nutzungsgeb."},
            {account_number: "42050", label: "Erlöse aus Veranstaltungen"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["sales_income"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end

          # Bestandsveränderungen
          [
            {account_number: "48280", label: "Zuschüsse von Verbänden und Behörden"},
            {account_number: "48290", label: "Sonstige Zuschüsse"},
            {account_number: "48300", label: "Sonstige betriebliche Erträge"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["inventory_changes_income"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end

          # Sonstige betriebliche Erträge
          [
            {account_number: "70200", label: "Zins- und Dividendenerträge"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["other_operating_income"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end
        end
      end

      def ensure_default_expense_accounts_for(accountable)
        say "Building default expense accounts for #{accountable.human}" do
          # Warenaufwand
          [
            {account_number: "51000", label: "Einkauf Roh-,Hilfs- und Betriebsstoffe"},
            {account_number: "52000", label: "Wareneingang"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["goods_expense"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end

          # Dienstleistungsaufwand / service_expense
          [
            {account_number: "59000", label: "Fremdleistungen"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["service_expense"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end

          # Lohn- und Gehaltsaufwand / wages_and_salaries_expense
          [
            {account_number: "60000", label: "Löhne und Gehälter"},
            {account_number: "60020", label: "Ehrenamtspauschale"},
            {account_number: "60040", label: "Übungsleiterpauschale"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["wages_and_salaries_expense"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end

          # Abschreibungen und Aufwendungen für Wertminderungen / depreciation_expense
          [
            {account_number: "62000", label: "Abschreibung immaterielle VermG"},
            {account_number: "62200", label: "Abschreibungen auf Sachanlagen"},
            {account_number: "62600", label: "Sofortabschreibung GWG"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["depreciation_expense"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end

          # Sonstige betriebliche Aufwendungen / other_operating_expenses
          [
            {account_number: "63000", label: "Sonstige betriebliche Aufwendungen"},
            {account_number: "63010", label: "Verwaltungskosten"},
            {account_number: "63020", label: "Aufwandsentschädigungen/Erstattung"},
            {account_number: "63050", label: "Kosten der Mitgliederverwaltung"},
            {account_number: "63090", label: "Raumkosten"},
            {account_number: "63100", label: "Miete, unbewegliche Wirtschaftsgüter"},
            {account_number: "63300", label: "Reinigung"},
            {account_number: "63350", label: "Instandhaltung betrieblicher Räume"},
            {account_number: "64000", label: "Versicherungen"},
            {account_number: "64500", label: "Reparatur u.Instandhaltung von Bauten"},
            {account_number: "66000", label: "Werbekosten"},
            {account_number: "66100", label: "Geschenke abzugsfähig ohne § 37b EStG"},
            {account_number: "66110", label: "Geschenke abzugsfähig mit § 37b EStG"},
            {account_number: "66310", label: "Kosten der Öffentlichkeitsarbeit"},
            {account_number: "68150", label: "Bürobedarf"},
            {account_number: "68550", label: "Nebenkosten des Geldverkehrs"},
            {account_number: "72000", label: "Abschreibung Finanzanlagen (dauerhaft)"},
            {account_number: "73000", label: "Zinsen und ähnliche Aufwendungen"},
            {account_number: "76500", label: "Sonstige Betriebssteuern"}
          ].each do |attrs|
            say "Creating account #{attrs[:account_number]} - #{attrs[:label]}" do
              Bgit::Accounting::Accounting::Account.where(account_category: @default_account_categories["other_operating_expenses"], accountable: accountable, account_number: attrs[:account_number], label: attrs[:label]).first_or_create!
            end
          end
        end
      end
    end
  end
end
