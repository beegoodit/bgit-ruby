require "rails_helper"

RSpec.describe Bgit::Invoicing::BillingRunService, type: :service do
  describe "basic usage" do
    let(:one_month_ago) { 1.month.ago }
    let(:two_monts_ago) { 2.months.ago }
    let(:now) { Time.zone.now }
    let(:owners) { create_list(:team, 3) + create_list(:bgit_frontend_auth_user, 3) }
    let(:active_subscriptions) do
      owners.map do |owner|
        resource = create(:bgit_invoicing_resource, owner: owner)
        create(:bgit_invoicing_subscription, resource: resource, active_from: two_monts_ago, active_to: now)
      end
    end
    let(:inactive_subscriptions) do
      owners.map do |owner|
        resource = create(:bgit_invoicing_resource, owner: owner)
        create(:bgit_invoicing_subscription, resource: resource, active_to: two_monts_ago.end_of_month)
        create(:bgit_invoicing_subscription, resource: resource, active_from: now.beginning_of_month)
      end +
        [create(:bgit_invoicing_subscription, active_from: one_month_ago.beginning_of_month)]
    end
    let(:month) { one_month_ago.month }
    let(:year) { one_month_ago.year }
    let(:attributes) do
      {
        month: month,
        year: year,
        owners: owners
      }
    end

    let(:options) do
      {}
    end

    subject { described_class.new(attributes, options) }

    describe "result" do
      before(:each) do
        active_subscriptions
        inactive_subscriptions
      end

      subject { described_class.call(attributes, options) }

      it { expect(subject).to be_a(described_class::Result) }
      it { expect(subject).to be_ok }

      describe "month" do
        it { expect(subject.month).to eq(month) }
      end

      describe "year" do
        it { expect(subject.year).to eq(year) }
      end

      describe "owners" do
        it { expect(subject.owners).to eq(owners) }
      end

      describe "active_subscriptions" do
        it { expect(subject.active_subscriptions).to include(*active_subscriptions) }
        it { expect(subject.active_subscriptions).not_to include(*inactive_subscriptions) }
      end
    end

    describe "persistence changes" do
      it "creates a new invoice for each subscription owner" do
        expect { subject.perform }.to change { Bgit::Invoicing::Invoice.count }.by(owners.count)
      end
    end
  end

  describe "when there are no owners with active subscriptions" do
    let(:month) { Time.zone.now.month }
    let(:year) { Time.zone.now.year }
    let(:attributes) do
      {
        month: month,
        year: year
      }
    end

    let(:options) do
      {}
    end

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { described_class.call(attributes, options) }

      it { expect(subject).to be_a(described_class::Result) }
      it { expect(subject).to be_ok }

      describe "month" do
        it { expect(subject.month).to eq(month) }
      end

      describe "year" do
        it { expect(subject.year).to eq(year) }
      end

      describe "owners" do
        it { expect(subject.owners).to match_array([]) }
      end

      describe "active_subscriptions" do
        it { expect(subject.active_subscriptions).to match_array([]) }
      end

      describe "inovices" do
        it { expect(subject.invoices).to match_array([]) }
      end
    end
  end
end
