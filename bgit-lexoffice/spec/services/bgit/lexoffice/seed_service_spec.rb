require "rails_helper"

RSpec.describe Bgit::Lexoffice::SeedService, type: :service do
  describe "basic usage" do
    subject { described_class.new }

    describe "persistence changes" do
      it { expect { subject.perform }.to change { Bgit::Lexoffice::Contact.count }.by(5) }
    end
  end
end
