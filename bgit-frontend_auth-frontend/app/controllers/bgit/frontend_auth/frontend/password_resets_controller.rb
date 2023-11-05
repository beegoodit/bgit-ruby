module Bgit
  module FrontendAuth
    module Frontend
      class PasswordResetsController < ::Bgit::FrontendAuth::Frontend::Configuration.base_controller.constantize
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::ResourceInflectionsConcern
        include Rao::ResourcesController::RestResourceUrlsConcern
        include Rao::ResourcesController::RestActionsConcern

        around_action :set_locale_from_url

        def self.resource_class
          Bgit::FrontendAuth::User
        end

        private

        def after_update_location
          user_path
        end

        def permitted_params
          params.require(:user).permit(:password, :password_confirmation)
        end

        def load_resource
          @resource = resource_class.find_using_perishable_token(params[:token])
          handle_user_not_found if @resource.nil?
        end

        def handle_user_not_found
          redirect_to new_user_session_path, notice: t("flash.bgit_frontend_auth.frontend.password_resets.edit.alert.perishable_token_invalid")
        end
      end
    end
  end
end
