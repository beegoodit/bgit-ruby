require "rails_helper"

RSpec.describe Bgit::Invoicing do
  it "has a version number" do
    expect(Bgit::Invoicing::VERSION).not_to be nil
  end
end
