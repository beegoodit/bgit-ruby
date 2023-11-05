require "rails_helper"

RSpec.describe Bgit::Invoicing::GenerateInvoiceForOwnerService, type: :service do
  describe "basic usage" do
    let(:bgit_frontend_auth_user) { create(:bgit_frontend_auth_user) }

    describe "result" do
      let(:attributes) do
        {
          owner: bgit_frontend_auth_user,
          year: 1.month.ago.year,
          month: 1.month.ago.month
        }
      end

      subject { described_class.call!(attributes) }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
    end
  end

  describe "when no subscriptions exist" do
    let(:bgit_frontend_auth_user) { create(:bgit_frontend_auth_user) }

    describe "result" do
      let(:attributes) do
        {
          owner: bgit_frontend_auth_user,
          year: 1.month.ago.year,
          month: 1.month.ago.month
        }
      end

      subject { described_class.call!(attributes) }

      describe "invoice" do
        it { expect(subject.invoice).to be_a(Bgit::Invoicing::Invoice) }
        it { expect(subject.invoice.owner).to eq(bgit_frontend_auth_user) }
        it { expect(subject.invoice.year).to eq(1.month.ago.year.to_s) }
        it { expect(subject.invoice.month).to eq(1.month.ago.month.to_s) }
        it { expect(subject.invoice.total_price).to eq(0) }
      end

      describe "line_items" do
        it { expect(subject.line_items).to be_empty }
      end

      describe "subscriptions" do
        it { expect(subject.subscriptions).to be_empty }
      end

      describe "resources" do
        it { expect(subject.resources).to be_empty }
      end
    end
  end

  describe "when subscriptions exist" do
    let(:bgit_frontend_auth_user) { create(:bgit_frontend_auth_user) }
    let(:product) { create(:bgit_invoicing_product) }
    let(:tier) { create(:bgit_invoicing_tier) }
    let(:resource) { create(:bgit_invoicing_resource, product: product, owner: bgit_frontend_auth_user) }
    let(:subscription) { create(:bgit_invoicing_subscription, resource: resource, tier: tier, active_from: 1.month.ago.beginning_of_month, active_to: 1.month.ago.end_of_month) }

    before(:each) { subscription }

    describe "result" do
      let(:attributes) do
        {
          owner: bgit_frontend_auth_user,
          year: 1.month.ago.year,
          month: 1.month.ago.month
        }
      end

      describe "when autosave is enabled" do
        subject { described_class.new(attributes, {autosave: true}) }

        describe "persistence changes" do
          it { expect { subject.perform }.to change { Bgit::Invoicing::Invoice.count }.by(1) }
          it { expect { subject.perform }.to change { Bgit::Invoicing::LineItem.count }.by(1) }
        end
      end

      describe "invoice" do
        subject { described_class.call!(attributes).invoice }

        it { expect(subject).to be_a(Bgit::Invoicing::Invoice) }
        it { expect(subject.owner).to eq(bgit_frontend_auth_user) }
        it { expect(subject.year).to eq(1.month.ago.year.to_s) }
        it { expect(subject.month).to eq(1.month.ago.month.to_s) }
        it { expect(subject.total_price.to_i).to eq(0) }
      end

      describe "line_items" do
        subject { described_class.call!(attributes).line_items }

        it { expect(subject).to be_a(Array) }
        it { expect(subject.size).to eq(1) }
        it { expect(subject.first).to be_a(Bgit::Invoicing::LineItem) }
      end

      describe "resources" do
        subject { described_class.call!(attributes).resources }

        it { expect(subject).to eq([resource]) }
      end

      describe "subscriptions" do
        subject { described_class.call!(attributes).subscriptions }

        it { expect(subject).to eq([subscription]) }
      end
    end
  end
end
