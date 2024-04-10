require "rails_helper"

module Bgit::Accounting
  RSpec.describe Contacts::Company, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:contact) }
      it { expect(subject).to have_many(:addresses) }
      it { expect(subject).to have_many(:contact_people) }
      it { expect(subject).to have_many(:email_addresses) }
      it { expect(subject).to have_many(:phone_numbers) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_contacts_company) }
    end
  end
end
