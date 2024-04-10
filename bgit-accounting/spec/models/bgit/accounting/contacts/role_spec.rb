require "rails_helper"

module Bgit::Accounting
  RSpec.describe Contacts::Role, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:contact) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_contacts_role) }

      it { expect(subject).to validate_presence_of(:number) }
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier).scoped_to(:contact_id) }
      it { expect(subject).to validate_inclusion_of(:identifier).in_array(%w[customer vendor]) }
    end
  end
end
