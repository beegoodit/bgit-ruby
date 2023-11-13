module Bgit
  module FrontendAuth
    module Frontend
      # Usage:
      #
      #     class ApplicationController < ActionController::Base
      #       view_helper Bgit::FrontendAuth::Frontend::ApplicationViewHelper, as: :bgit_frontend_auth_frontend_helper
      #     end
      #
      class ApplicationViewHelper < Rao::ViewHelper::Base
        # Usage:
        #
        #     # app/views/layouts/application.html.erb
        #     <%= bgit_frontend_auth_frontend_helper(self).render_navigation %>
        #
        def render_navigation(options = {})
          options.reverse_merge!(dropdown: false, bootstrap_version: 4)

          bootstrap_version = options.delete(:bootstrap_version)

          send("render_with_bootstrap_#{bootstrap_version}", options)
        end

        private

        def render_with_bootstrap_3(options)
          dropdown = options.delete(:dropdown)
          if dropdown
            c.render partial: "bgit/frontend_auth/frontend/application_view_helper/bootstrap_3/render_dropdown"
          else
            c.render partial: "bgit/frontend_auth/frontend/application_view_helper/bootstrap_3/render"
          end
        end

        def render_with_bootstrap_4(options)
          dropdown = options.delete(:dropdown)
          if dropdown
            c.render partial: "bgit/frontend_auth/frontend/application_view_helper/bootstrap_4/render_dropdown"
          else
            c.render partial: "bgit/frontend_auth/frontend/application_view_helper/bootstrap_4/render"
          end
        end
      end
    end
  end
end
