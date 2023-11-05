module Bgit
  module FrontendAuth
    module Frontend
      class PasswordResetRequestsController < ::Bgit::FrontendAuth::Frontend::Configuration.base_controller.constantize
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::ResourceInflectionsConcern
        include Rao::ResourcesController::RestResourceUrlsConcern
        include Rao::ResourcesController::RestActionsConcern

        around_action :set_locale_from_url

        def self.resource_class
          Bgit::FrontendAuth::PasswordResetRequest
        end

        private

        def initialize_resource_for_create
          super
          @resource.host = request.host
        end

        def after_create_location
          new_user_session_path
        end

        def success_message
          t(".success_message")
        end

        def permitted_params
          params.require(:password_reset_request).permit(:email)
        end
      end
    end
  end
end
