module Bgit
  module FrontendAuth
    module Frontend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor(:base_controller) do
          "::ApplicationController"
        end

        mattr_accessor(:base_mailer) do
          "::ApplicationMailer"
        end

        mattr_accessor(:enable_registrations) do
          true
        end

        mattr_accessor(:allow_users_to_destroy_self) do
          true
        end

        mattr_accessor(:email_from_address) do
          "frontend@domain.local"
        end

        mattr_accessor(:application_name) do
          "Application Name"
        end

        mattr_accessor(:after_sign_in_url) do
          -> { main_app.root_path }
        end

        mattr_accessor(:after_sign_out_url) do
          -> { main_app.root_path }
        end
      end
    end
  end
end
