require "rails_helper"

RSpec.describe "/de/backend/accounting/postings", type: :feature do
  let(:resource_class) { Keepr::Posting }

  describe "REST actions" do
    let(:resource) { create(:posting) }
    let(:resources) { create_list(:posting, 3) }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }
  end
end
