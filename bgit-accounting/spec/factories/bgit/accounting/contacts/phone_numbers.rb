FactoryBot.define do
  factory :bgit_accounting_contacts_phone_number, class: "Bgit::Accounting::Contacts::PhoneNumber" do
    association(:company, factory: :bgit_accounting_contacts_company)
    role { "business" }
    number { "MyString" }
  end
end
