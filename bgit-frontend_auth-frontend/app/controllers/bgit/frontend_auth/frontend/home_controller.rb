module Bgit
  module FrontendAuth
    module Frontend
      class HomeController < ::Bgit::FrontendAuth::Frontend::Configuration.base_controller.constantize
        include Rao::ResourcesController::LocationHistoryConcern
        include Bgit::FrontendAuth::Frontend::Controller::CurrentUserConcern

        before_action :authenticate_frontend_auth_user!
        
        def index
        end
      end
    end
  end
end