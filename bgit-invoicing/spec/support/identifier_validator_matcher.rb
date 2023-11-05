# Add matcher for identifier validation

RSpec::Matchers.define :validate_identifiability_of do |attribute|
  match do |model|
    message = I18n.t("errors.messages.not_an_identifier")
    # check it validates for alphanumeric chars and dashes
    model.send("#{attribute}=", "abc123-")
    model.valid?
    expect(model.errors[attribute]).not_to include(message)

    # check it does not validate for other chars
    model.send("#{attribute}=", "abc123_")
    model.valid?
    expect(model.errors[attribute]).to include(message)
  end
end
