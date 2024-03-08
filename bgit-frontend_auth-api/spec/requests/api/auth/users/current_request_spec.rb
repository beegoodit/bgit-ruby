require "rails_helper"

RSpec.describe "/api/auth/users/current", type: :request do
  let(:base_path) { "/api/auth/users/current" }

  let(:headers) { {
    "Accept" => "application/json",
    "Content-Type" => "application/json" 
  } }
  
  describe "unauthorized access" do
    let(:authorization_headers) { {
      "Authorization" => "Bearer invalid-token"
    } }

    before(:each) do
      get(base_path, headers: headers.merge(authorization_headers))
    end

    it { expect(response).to have_http_status(401) }
  end

  describe "authorized access" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }
    let(:token) { sign_in(user) }

    let(:authorization_headers) { {
      "Authorization" => "Bearer #{token}"
    } }

    before(:each) do
      get(base_path, headers: headers.merge(authorization_headers))
    end

    it { expect(response).to have_http_status(200) }

    describe "response body" do
      let(:json) { response.parsed_body }

      it { expect(json).to have_key("id") }
      it { expect(json).to have_key("email") }
    end
  end
end
