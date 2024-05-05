require "rails_helper"

module Bgit::Invoicing
  RSpec.describe Invoice, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:owner) }
      it { expect(subject).to have_many(:line_items) }
    end

    describe "scopes" do
      it { expect(described_class).to respond_to(:for_year) }
    end

    describe "validations" do
      subject { create(:bgit_invoicing_invoice) }

      it { expect(subject).to validate_presence_of(:owner) }
      it { expect(subject).to validate_presence_of(:shipping_date) }
    end

    describe "total_net_amount" do
      let(:invoice) { create(:bgit_invoicing_invoice) }
      let(:line_items) { create_list(:bgit_invoicing_line_item, 3, invoice: invoice) }

      before(:each) do
        line_items
      end

      it { expect(invoice.total_net_amount).to eq(invoice.line_items.sum(&:net_amount)) }
    end

    describe "total_gross_amount" do
      let(:invoice) { create(:bgit_invoicing_invoice) }
      let(:line_items) { create_list(:bgit_invoicing_line_item, 3, invoice: invoice) }

      before(:each) do
        line_items
      end

      it { expect(invoice.total_gross_amount).to eq(invoice.line_items.sum(&:gross_amount)) }
    end

    describe "state machine" do
      describe "transitions" do
        describe "from draft" do
          let(:invoice) { create(:bgit_invoicing_invoice, billing_state: "draft") }

          describe "to ready" do
            it { expect { invoice.mark_as_ready! }.to change { invoice.billing_state }.from("draft").to("ready") }

            describe "when set_invoice_number_on_ready is enabled" do
              before(:each) { Bgit::Invoicing::NumberRanges::SeedService.call! }

              around(:each) do |example|
                @_set_invoice_number_on_ready = Bgit::Invoicing::Configuration.set_invoice_number_on_ready
                Bgit::Invoicing::Configuration.set_invoice_number_on_ready = true
                example.run
                Bgit::Invoicing::Configuration.set_invoice_number_on_ready = @_set_invoice_number_on_ready
              end

              it { expect { invoice.mark_as_ready! }.to change { invoice.billing_state }.from("draft").to("ready") }
              it { expect { invoice.mark_as_ready! }.to change { invoice.invoice_number&.match?(/\ARE\d{6}-\d{4}\z/) }.from(nil).to(true) }
            end
          end
        end
      end
    end
  end
end
