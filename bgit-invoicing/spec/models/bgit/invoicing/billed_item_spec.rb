require "rails_helper"

module Bgit::Invoicing
  RSpec.describe BilledItem, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:line_item) }
      it { expect(subject).to belong_to(:billable) }
    end

    describe "validations" do
    end
  end
end
