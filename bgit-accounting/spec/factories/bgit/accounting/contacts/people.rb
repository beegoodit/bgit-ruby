FactoryBot.define do
  factory :bgit_accounting_contacts_person, class: "Bgit::Accounting::Contacts::Person" do
    association(:contact, factory: :bgit_accounting_contacts_contact)
    salutation { "Frau" }
    firstname { "Jane" }
    lastname { "Doe" }
  end
end
