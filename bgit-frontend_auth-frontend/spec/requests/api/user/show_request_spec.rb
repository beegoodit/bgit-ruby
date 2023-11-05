require "rails_helper"

RSpec.describe "/api/user", type: :request do
  let(:base_path) { "/api/user" }

  describe "unauthorized access" do
    let(:api_token) { "uh-oh-this-is-invalid" }
    let(:params) { { } }
    let(:headers) { { "Accept" => "application/json", "Authorization" => "Bearer: #{api_token}" } }

    before(:each) do
      get base_path, params: params, headers: headers
    end

    it { pending; expect(response).to have_http_status(403) }
  end

  describe "authorized access" do
    let(:user) { create(:frontend_auth_user, :authenticable) }

    let(:params) { { } }

    before(:each) do
      get base_path, params: params, headers: headers
    end

    describe "response" do
      let(:parsed_response) { JSON.parse(response.body) }
      
      it { expect(response).to have_http_status(200) }
      it { pending; expect(parsed_response.keys).to match_array(["email"]) }
    end
  end
end
