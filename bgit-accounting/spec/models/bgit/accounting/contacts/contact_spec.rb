require "rails_helper"

module Bgit::Accounting
  RSpec.describe Contacts::Contact, type: :model do
    describe "associations" do
      it { expect(subject).to have_one(:company) }
      it { expect(subject).to have_one(:person) }
      it { expect(subject).to have_many(:roles) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_contacts_contact) }

      it { expect(subject).to validate_presence_of(:name) }
    end
  end
end
