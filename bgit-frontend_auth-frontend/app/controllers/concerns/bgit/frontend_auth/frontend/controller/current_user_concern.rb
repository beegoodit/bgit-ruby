module Bgit
  module FrontendAuth
    module Frontend
      module Controller
        # Usage:
        #
        #    # app/controllers/frontend/application_controller.rb
        #    module Frontend
        #      class ApplicationController < ApplicationController
        #        include Bgit::FrontendAuth::Frontend::Controller::CurrentUserConcern
        #      end
        #    end
        #
        module CurrentUserConcern
          extend ActiveSupport::Concern

          included do
            helper_method :frontend_auth_user_signed_in?
            helper_method :current_frontend_auth_user
          end

          private

          def current_frontend_auth_user
            @current_frontend_auth_user ||= current_frontend_auth_user_session&.user
          end

          def current_frontend_auth_user_session
            @current_frontend_auth_user_session ||= Bgit::FrontendAuth::UserSession.find
          end

          def authenticate_frontend_auth_user!
            unless frontend_auth_user_signed_in?
              store_location
              handle_frontend_authentication_failure
              return false
            end
            true
          end

          def frontend_auth_user_signed_in?
            !current_frontend_auth_user.nil?
          end

          def handle_frontend_authentication_failure
            respond_to do |format|
              format.html { redirect_to(frontend_authentication_failed_path, notice: t("bgit.frontend_auth.frontend.controller.current_user_concern.authentication_failed")) }
            end
          end

          def frontend_authentication_failed_path
            bgit_frontend_auth_frontend.new_user_session_path
          end
        end
      end
    end
  end
end
