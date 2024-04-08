module Bgit
  module Accounting
    module Model
      module KeeprGroupExtensionsConcern
        extend ActiveSupport::Concern

        class_methods do
          def human_value_name(attribute, value)
            I18n.t("activerecord.values.#{model_name.i18n_key}.#{attribute}.#{value}")
          end
        end

        def human
          to_s
        end

        def human_value_name(attribute)
          self.class.human_value_name(attribute, send(attribute))
        end
      end
    end
  end
end
