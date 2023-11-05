FactoryBot.define do
  factory :bgit_lexoffice_invoice, class: Bgit::Lexoffice::Invoice do
    sequence(:lexoffice_id) { |i| SecureRandom.uuid }
  end
end
