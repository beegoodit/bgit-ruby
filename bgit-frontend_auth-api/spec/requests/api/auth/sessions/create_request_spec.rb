require "rails_helper"

RSpec.describe "/api/auth/sessions", type: :request do
  let(:base_path) { "/api/auth/sessions" }

  let(:headers) { {
    "Accept" => "application/json",
    "Content-Type" => "application/json" 
  } }
  
  describe "unauthorized access" do
    let(:body) { {
      email: "invalid-username",
      password: "invalid-password"
    } }

    before(:each) do
      post(base_path, headers: headers, params: body.to_json)
    end

    it { expect(response).to have_http_status(401) }
  end

  describe "authorized access" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }

    let(:body) { {
      email: user.email,
      password: user.password
    } }

    before(:each) do
      post(base_path, headers: headers, params: body.to_json)
    end

    it { expect(response).to have_http_status(202) }

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
