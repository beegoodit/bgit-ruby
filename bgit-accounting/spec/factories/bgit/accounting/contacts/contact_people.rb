FactoryBot.define do
  factory :bgit_accounting_contacts_contact_person, class: "Bgit::Accounting::Contacts::ContactPerson" do
    association(:company, factory: :bgit_accounting_contacts_company)
    salutation { "MyString" }
    firstname { "MyString" }
    lastname { "MyString" }
    primary { false }
    email { "MyString" }
    phone { "MyString" }
  end
end
