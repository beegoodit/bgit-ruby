module Bgit
  module Accounting
    module Model
      module KeeprAccountExtensionsConcern
        extend ActiveSupport::Concern

        included do
          before_validation :set_number, if: :new_record?
        end

        class_methods do
          def human_value_name(attribute, value)
            I18n.t("activerecord.values.#{model_name.i18n_key}.#{attribute}.#{value}")
          end
        end

        def balance_debit(date = nil)
          scope = case date
          when nil
            keepr_postings
          when Date
            keepr_postings
              .joins(:keepr_journal)
              .where("keepr_journals.date <= ?", date)
          when Range
            keepr_postings
              .joins(:keepr_journal)
              .where(keepr_journals: {date: date.first..date.last})
          else
            raise ArgumentError
          end

          scope.debits.sum(:amount)
        end

        def balance_credit(date = nil)
          scope = case date
          when nil
            keepr_postings
          when Date
            keepr_postings
              .joins(:keepr_journal)
              .where("keepr_journals.date <= ?", date)
          when Range
            keepr_postings
              .joins(:keepr_journal)
              .where(keepr_journals: {date: date.first..date.last})
          else
            raise ArgumentError
          end

          scope.credits.sum(:amount)
        end

        def human
          "#{number} (#{human_value_name(:kind_symbol)}) #{name}"
        end

        def human_value_name(attribute)
          self.class.human_value_name(attribute, send(attribute))
        end

        def kind_symbol
          kind
        end

        private

        def set_number
          self.number ||= loop do
            number = Random.new.rand(9_900_000..9_999_999)
            break number unless self.class.where(number: number).exists?
          end
        end
      end
    end
  end
end
