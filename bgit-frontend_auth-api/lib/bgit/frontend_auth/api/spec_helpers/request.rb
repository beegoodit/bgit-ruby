module Bgit
  module FrontendAuth::Api
    module SpecHelpers
      # Usage:
      #
      #    # spec/support/bgit-frontend_auth-api.rb
      #    require "bgit/frontend_auth/api/spec_helpers/request"
      #
      #    RSpec.configure do |config|
      #      config.include Bgit::FrontendAuth::Api::SpecHelpers::Feature, type: :request
      #    end
      #
      module Request
        def sign_up(user_attributes)
          post("/api/auth/users", headers: { "Accept" => "application/json", "Content-Type" => "application/json" }, params: { user: user_attributes })
          expect(response).to have_http_status(201)
          response.parsed_body["token"]
        end

        # Example:
        #
        #    # spec/requests/api/blog/posts
        #    require "rails_helper"
        #
        #    RSpec.describe "/api/blog/posts", type: :request do
        #      let(:user) { create(:bgit_frontend_auth_user, :authenticable) }
        #      let(:token) { sign_in(user) }
        #
        #      let(:base_path) { "/api/blog/posts" }
        #      let(:headers) { { "Authorization" => "Bearer #{token}" } }
        #
        #      before(:each) do
        #        get(base_path, headers: headers)
        #      end
        #
        #      it { expect(response).to have_http_status(200) }
        #    end
        #
        def sign_in(user)
          post("/api/auth/sessions", headers: { "Accept" => "application/json", "Content-Type" => "application/json" }, params: { email: user.email, password: user.password }.to_json)
          expect(response).to have_http_status(202)
          response.parsed_body["token"]
        end

        # Enables the registrations feature, so you can signup users.
        #
        # Usage:
        #
        #     # spec/features/registrations_request_spec.rb
        #     require "rails_helper"
        #     require "bgit/frontend_auth/frontend/spec_helpers/request"
        #
        #     RSpec.feature "Registrations", type: :request do
        #       include Bgit::FrontendAuth::Api::SpecHelpers::Request
        #
        #       around(:each) { |example| with_enabled_registrations { example } }
        #
        #       it do
        #         expect { sign_up(user_attributes) }.to change { Bgit::FrontendAuth::Frontend::User.count }.from(0).to(1)
        #       end
        #     end
        #
        def with_enabled_registrations
          _setup_enabled_registrations
          yield
          _undo_setup_enabled_registrations
        end

        def _setup_enabled_registrations
          @_enabled_registrations = Bgit::FrontendAuth::Api::Configuration.enable_registrations
          Bgit::FrontendAuth::Api::Configuration.enable_registrations = true
        end

        def _undo_setup_enabled_registrations
          Bgit::FrontendAuth::Api.enable_registrations = @_enabled_registrations
          remove_instance_variable(:@_enabled_registrations)
        end
      end
    end
  end
end
