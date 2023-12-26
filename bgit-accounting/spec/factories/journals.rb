FactoryBot.define do
  factory :journal, class: Keepr::Journal do
    # keepr_postings_attributes do
    #   [
    #     attributes_for(:posting).merge(side: Keepr::Posting::SIDE_DEBIT),
    #     attributes_for(:posting).merge(side: Keepr::Posting::SIDE_CREDIT)
    #   ]
    # end
    after(:build) do |journal|
      ([Keepr::Posting::SIDE_DEBIT, Keepr::Posting::SIDE_CREDIT] - journal.keepr_postings.map(&:side).uniq).each do |side|
        journal.keepr_postings.build(attributes_for(:posting, side: side).merge(keepr_account: build(:account)))
      end
    end
  end
end
