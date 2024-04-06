FactoryBot.define do
  factory :bgit_accounting_vouchers_unchecked, class: "Bgit::Accounting::Vouchers::Unchecked" do
    association(:accountable, factory: :bgit_accounting_accounting_account)
    asset { Rack::Test::UploadedFile.new(Bgit::Accounting::Engine.root.join(*%w[spec files bgit accounting vouchers vouchers example.pdf]), "application/pdf") }
  end
end
