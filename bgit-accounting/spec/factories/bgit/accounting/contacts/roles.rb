FactoryBot.define do
  factory :bgit_accounting_contacts_role, class: "Bgit::Accounting::Contacts::Role" do
    association(:contact, factory: :bgit_accounting_contacts_contact)
    identifier { "customer" }
    number { "MyString" }
  end
end
