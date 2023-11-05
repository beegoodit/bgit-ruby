module Bgit
  module Invoicing
    module Frontend
      class ApplicationController < Bgit::Invoicing::Frontend::Configuration.base_controller.constantize
        include Pundit::Authorization
        after_action :verify_authorized

        private

        def current_engine
          @current_engine ||= Bgit::Invoicing::Frontend::Engine
        end

        def pundit_user
          current_frontend_auth_user
        end
      end
    end
  end
end
