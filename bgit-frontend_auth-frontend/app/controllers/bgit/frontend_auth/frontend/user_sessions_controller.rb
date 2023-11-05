module Bgit
  module FrontendAuth
    module Frontend
      class UserSessionsController < ::Bgit::FrontendAuth::Frontend::Configuration.base_controller.constantize
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::ResourceInflectionsConcern
        # include Rao::ResourcesController::RestResourceUrlsConcern
        # include Rao::ResourcesController::RestActionsConcern
        # include Rao::ResourcesController::LocationHistoryConcern

        include Bgit::FrontendAuth::Frontend::Controller::RedirectBackConcern

        skip_before_action :authenticate_user!, only: [:new, :create], raise: false
        skip_before_action :store_location, only: [:new, :create], raise: false

        around_action :set_locale_from_url

        def self.resource_class
          Bgit::FrontendAuth::UserSession
        end

        def new
          @resource = resource_class.new
        end

        def create
          @resource = resource_class.new(permitted_params)

          if @resource.save
            flash[:notice] = t(".signed_in")
            # redirect_to after_sign_in_url
            redirect_back_or(after_sign_in_url)
          else
            render action: :new
          end
        end

        def destroy
          resource_class.find.destroy
          flash[:notice] = t(".signed_out")
          redirect_to after_sign_out_url
        end

        private

        def after_sign_in_url
          # frontend_dashboard.scans_path
          instance_exec(&Bgit::FrontendAuth::Frontend::Configuration.after_sign_in_url)
        end

        def after_sign_out_url
          # "/#{I18n.locale}"
          instance_exec(&Bgit::FrontendAuth::Frontend::Configuration.after_sign_out_url)
        end

        def permitted_params
          params.require(:user_session).permit(:email, :password).to_h
        end
      end
    end
  end
end
