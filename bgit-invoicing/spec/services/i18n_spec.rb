# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Translations", type: :model do
  {
    # Bgit::Invoicing::BillingRunService => {}
    # Bgit::Invoicing::GenerateInvoiceForOwnerService => {}
  }.each do |model, options|
    options[:locales] ||= I18n.available_locales
    options[:locales].each do |locale|
      I18n.locale = locale

      describe "for locale #{locale}:" do
        describe "#{model} translations" do
          it "include one" do
            I18n.locale = locale
            i18n_key = ["activemodel", "models", model.name.underscore].join(".")
            expect(I18n.translate!(i18n_key, **options)[:one]).to be_a(String)
          end

          it "include other" do
            I18n.locale = locale
            i18n_key = ["activemodel", "models", model.name.underscore].join(".")
            expect(I18n.translate!(i18n_key, **options)[:other]).to be_a(String)
          end

          describe "for attributes" do
            model.attribute_names.each do |attribute_name|
              it "include #{attribute_name}" do
                I18n.locale = locale
                i18n_key = ["activemodel", "attributes", model.name.underscore, attribute_name].join(".")
                expect(I18n.translate!(i18n_key)).to be_a(String)
              end
            end
          end
        end
      end
    end
  end
end
