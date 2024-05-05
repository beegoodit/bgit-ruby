require "rails_helper"

module Bgit::Accounting
  RSpec.describe Contacts::Address, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:company) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_contacts_address) }

      it { expect(subject).to validate_presence_of(:street) }
      it { expect(subject).to validate_presence_of(:zip_code) }
      it { expect(subject).to validate_presence_of(:city) }
      it { expect(subject).to validate_presence_of(:country_code) }
      it { expect(subject).to validate_presence_of(:role) }
      it { expect(subject).to validate_inclusion_of(:role).in_array(%w[billing shipping]) }
    end
  end
end
