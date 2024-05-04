FactoryBot.define do
  factory :bgit_accounting_vouchers_voucher, class: "Bgit::Accounting::Vouchers::Voucher" do
    association(:contact, factory: :bgit_accounting_contacts_contact)
    asset { Rack::Test::UploadedFile.new(Bgit::Accounting::Engine.root.join(*%w[spec files bgit accounting vouchers vouchers example.pdf]), "application/pdf") }
    kind { "unchecked" }
    sequence(:number) { |i| "RE-#{i}" }
  end
end
