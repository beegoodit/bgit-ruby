module Bgit
  module Accounting
    module Model
      module KeeprPostingExtensionsConcern
        extend ActiveSupport::Concern

        class_methods do
          def human_value_name(attribute, value)
            I18n.t("activerecord.values.#{model_name.i18n_key}.#{attribute}.#{value}")
          end
        end

        def human
          "#{keepr_account.human}: #{amount}"
        end
      end
    end
  end
end
