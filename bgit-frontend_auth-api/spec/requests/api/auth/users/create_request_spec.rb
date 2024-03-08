require "rails_helper"

RSpec.describe "/api/auth/users", type: :request do
  let(:base_path) { "/api/auth/users" }
  
  describe "POST /" do # create
    around(:each) { |example| with_enabled_registrations { example.run } }
    
    let(:headers) { {
      "Accept" => "application/json",
      "Content-Type" => "application/json" 
    } }
    
    let(:body) { {
      email: "jane.doe@domain.local",
      password: "Test1234!"
    } }

    before(:each) do
      post(base_path, headers: headers, params: body.to_json)
    end

    it { expect(response).to have_http_status(201) }

    describe "response body" do
      let(:json) { JSON.parse(response.body) }

      it { expect(json).to have_key("user") }
      it { expect(json).to have_key("token") }

      describe "user" do
        let(:user_json) { json["user"] }

        it { expect(user_json).to have_key("id") }
        it { expect(user_json).to have_key("email") }
      end

      describe "token" do
        let(:token) { json["token"] }

        it { expect(token).to be_a(String) }
        it { expect(token).not_to be_empty }
      end
    end
  end
end