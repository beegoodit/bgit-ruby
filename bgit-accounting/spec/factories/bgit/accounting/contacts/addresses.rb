FactoryBot.define do
  factory :bgit_accounting_contacts_address, class: "Bgit::Accounting::Contacts::Address" do
    association(:company, factory: :bgit_accounting_contacts_company)
    role { "billing" }
    supplement { "MyString" }
    street { "MyString" }
    zip_code { "MyString" }
    city { "MyString" }
    country_code { "MyString" }
  end
end
