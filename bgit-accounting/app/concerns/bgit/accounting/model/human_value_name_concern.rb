module Bgit
  module Accounting
    module Model
      module HumanValueNameConcern
        extend ActiveSupport::Concern

        class_methods do
          def human_value_name(attribute_name, value)
            I18n.t("activerecord.values.#{name.underscore}.#{attribute_name}.#{value}")
          end
        end

        def human_value_name(attribute_name)
          human_value_name(attribute_name, send(attribute_name))
        end
      end
    end
  end
end
