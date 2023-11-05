module Bgit
  module FrontendAuth
    module Frontend
      class UsersController < ::Bgit::FrontendAuth::Frontend::Configuration.base_controller.constantize
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::ResourceInflectionsConcern
        include Rao::ResourcesController::RestResourceUrlsConcern
        include Rao::ResourcesController::RestActionsConcern
        include Rao::ResourcesController::LocationHistoryConcern

        include Bgit::FrontendAuth::Frontend::Controller::CurrentUserConcern

        helper Rao::Component::ApplicationHelper

        around_action :set_locale_from_url

        before_action :authenticate_frontend_auth_user!, except: [:new, :create]

        def self.resource_class
          Bgit::FrontendAuth::User
        end

        private

        def initialize_resource_for_create
          super
          @resource.active = true
          @resource.approved = true
          @resource.confirmed = true
        end

        def load_resource
          @resource = current_frontend_auth_user
        end

        def after_create_location
          resource_class.acts_as_authentic_config[:log_in_after_create] ? user_path : main_app.root_path
        end

        def after_update_location
          user_path
        end

        def permitted_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
