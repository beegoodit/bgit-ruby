module Bgit
  module Organisations
    module Frontend
      class TeamsController < Bgit::Organisations::Frontend::ApplicationController
        before_action :load_collection, only: [:index]
        before_action :load_resource, only: [:show]

        helper Rao::Component::ApplicationHelper

        helper_method :available_rest_actions, :resource_class

        def self.resource_class
          Bgit::Organisations::Team
        end

        def index
          authorize(resource_class)
        end

        def show
          authorize(@resource)
        end

        private

        def available_rest_actions
          [:index, :show]
        end

        def resource_class
          self.class.resource_class
        end

        def load_collection
          @collection = current_frontend_auth_user.teams
        end

        def load_resource
          @resource = current_frontend_auth_user.teams.find(params[:id])
        end
      end
    end
  end
end
