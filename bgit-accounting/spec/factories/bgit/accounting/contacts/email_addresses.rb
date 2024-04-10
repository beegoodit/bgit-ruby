FactoryBot.define do
  factory :bgit_accounting_contacts_email_address, class: "Bgit::Accounting::Contacts::EmailAddress" do
    association(:company, factory: :bgit_accounting_contacts_company)
    role { "business" }
    email { "MyString" }
  end
end
