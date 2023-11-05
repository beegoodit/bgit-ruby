require "rails_helper"

module Bgit::Invoicing
  RSpec.describe Subscription, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:tier) }
      it { expect(subject).to belong_to(:resource) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:active_from) }
      it { expect(subject).to validate_presence_of(:active_to) }
    end

    describe "scopes" do
      it { expect(described_class).to respond_to(:active_at) }
      it { expect(described_class).to respond_to(:owned_by) }

      describe "active_at" do
        describe "does not return subscriptions that are not active at the given month" do
          let(:month) { 1.month.ago.month }
          let(:year) { 1.month.ago.year }
          let(:active_subscription) { create(:bgit_invoicing_subscription, active_from: 2.months.ago, active_to: 1.month.ago) }
          let(:inactive_subscription) { create(:bgit_invoicing_subscription, active_from: 2.months.ago, active_to: 2.months.ago) }

          subject { described_class.active_at(month, year) }

          it { expect(subject).to include(active_subscription) }
          it { expect(subject).to_not include(inactive_subscription) }
        end
      end

      describe "owned_by" do
        describe "does not return subscriptions owned by other owners" do
          let(:owner) { create(:team) }
          let(:other_owner) { create(:team) }
          let(:resource) { create(:bgit_invoicing_resource, owner: owner) }
          let(:other_resource) { create(:bgit_invoicing_resource, owner: other_owner) }
          let!(:subscription) { create(:bgit_invoicing_subscription, resource: resource) }
          let!(:other_subscription) { create(:bgit_invoicing_subscription, resource: other_resource) }

          subject { described_class.owned_by(owner) }

          it { expect(subject).to include(subscription) }
          it { expect(subject).to_not include(other_subscription) }
        end
      end
    end
  end
end
