require "rails_helper"

RSpec.describe Bgit::Invoicing::SeedService, type: :service do
  describe "basic usage" do
    subject { described_class.new }

    describe "persistence changes" do
      it { expect { subject.perform }.to change { Bgit::Invoicing::Product.count }.by(4) }
      it { expect { subject.perform }.to change { Bgit::Invoicing::Resource.count }.by(61) }
      it { expect { subject.perform }.to change { Bgit::Invoicing::Subscription.count }.by(61) }
      it { expect { subject.perform }.to change { Bgit::Invoicing::Tier.count }.by(12) }
    end
  end
end
