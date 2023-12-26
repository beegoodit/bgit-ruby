FactoryBot.define do
  factory :posting, class: Keepr::Posting do
    association(:keepr_account, factory: :account)
    # association(:keepr_journal, factory: :journal)
    # association(:keepr_cost_center, factory: :cost_center)
    side { Keepr::Posting::SIDE_DEBIT }
    amount { 100 }

    after(:build) do |posting|
      posting.keepr_journal ||= build(:journal, keepr_postings: [posting])
    end
  end
end
