module Bgit
  module Accounting
    module Model
      module KeeprAccountExtensionsConcern
        extend ActiveSupport::Concern

        class_methods do
          def human_value_name(attribute, value)
            I18n.t("activerecord.values.#{model_name.i18n_key}.#{attribute}.#{value}")
          end
        end

        def human
          [accountable&.human, self, self.class.human_value_name(:kind, kind)].compact.join(" - ")
        end
      end
    end
  end
end
