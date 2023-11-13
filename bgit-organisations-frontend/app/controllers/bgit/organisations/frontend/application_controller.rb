module Bgit
  module Organisations
    module Frontend
      class ApplicationController < Bgit::Organisations::Frontend::Configuration.base_controller.constantize
        include Pundit::Authorization
        after_action :verify_authorized

        private

        def current_engine
          @current_engine ||= Bgit::Organisations::Frontend::Engine
        end

        def pundit_user
          current_frontend_auth_user
        end
      end
    end
  end
end
