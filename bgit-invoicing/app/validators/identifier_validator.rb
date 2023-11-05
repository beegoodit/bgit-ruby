# Validates that the identifier using alphanumeric characters and dashes.
class IdentifierValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    unless /\A[a-z0-9\-]+\z/.match?(value)
      record.errors.add(attribute, :not_an_identifier, message: options[:message] || t("errors.messages.not_an_identifier", record_key: record.class.model_name.i18n_key, attribute: attribute))
    end
  end

  private

  def t(key, record_key: nil, attribute: nil)
    default = I18n.t("errors.messages.not_an_identifier")
    I18n.t(key, scope: "activerecord.errors.models.#{record_key}.attributes.#{attribute}", default: default)
  end
end
