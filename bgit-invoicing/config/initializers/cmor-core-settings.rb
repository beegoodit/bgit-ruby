Rails.application.config.to_prepare do
  Cmor::Core::Settings.configure do |config|
    config.register(
      namespace: :bgit_invoicing,
      key: "enforce_unique_invoices_per_owner_and_month",
      type: :boolean,
      default: true,
      validations: {inclusion: {in: [true, false]}}
    )
  end
end
