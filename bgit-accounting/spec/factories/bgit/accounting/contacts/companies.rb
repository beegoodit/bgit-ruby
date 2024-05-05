FactoryBot.define do
  factory :bgit_accounting_contacts_company, class: "Bgit::Accounting::Contacts::Company" do
    association(:contact, factory: :bgit_accounting_contacts_contact)
    tax_number { "MyString" }
    vat_identifier { "MyString" }
  end
end
