FactoryBot.define do
  factory :bgit_accounting_contacts_contact, class: "Bgit::Accounting::Contacts::Contact" do
    name { "MyString" }
    note { "MyText" }
  end
end
