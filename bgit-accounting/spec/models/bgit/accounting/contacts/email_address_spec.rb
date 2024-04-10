require "rails_helper"

module Bgit::Accounting
  RSpec.describe Contacts::EmailAddress, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:company) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_contacts_email_address) }

      it { expect(subject).to validate_presence_of(:email) }
      it { expect(subject).to validate_presence_of(:role) }
      it { expect(subject).to validate_uniqueness_of(:role).scoped_to(:company_id) }
      it { expect(subject).to validate_inclusion_of(:role).in_array(%w[business office private other]) }
    end
  end
end
