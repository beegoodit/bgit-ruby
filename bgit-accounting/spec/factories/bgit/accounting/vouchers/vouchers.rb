FactoryBot.define do
  factory :bgit_accounting_vouchers_voucher, class: "Bgit::Accounting::Vouchers::Voucher" do
    association(:accountable, factory: :bgit_accounting_accounting_account)
    asset { Rack::Test::UploadedFile.new(Bgit::Accounting::Engine.root.join(*%w[spec files bgit accounting vouchers vouchers example.pdf]), "application/pdf") }
    type { "Bgit::Accounting::Vouchers::Unchecked" }

    trait :with_amounts do
      after(:build) do |voucher|
        voucher.amounts << build_list(:bgit_accounting_vouchers_amount, 3, voucher: voucher)
        voucher.amount = voucher.amounts.sum(&:net_amount)
      end
    end

    trait :unchecked do
      type { "Bgit::Accounting::Vouchers::Unchecked" }
    end
  end
end
