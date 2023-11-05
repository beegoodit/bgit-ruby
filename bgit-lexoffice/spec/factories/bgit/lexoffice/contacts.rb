FactoryBot.define do
  factory :bgit_lexoffice_contact, class: Bgit::Lexoffice::Contact do
    sequence(:lexoffice_id) { |i| SecureRandom.uuid }
  end
end
