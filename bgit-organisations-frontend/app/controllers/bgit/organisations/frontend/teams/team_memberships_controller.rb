module Bgit
  module Organisations
    module Frontend
      module Teams
        class TeamMembershipsController < Bgit::Organisations::Frontend::ApplicationController
          include Rao::ResourcesController::RestActionsConcern
          include Rao::ResourcesController::ResourcesConcern

          helper Rao::Component::ApplicationHelper

          def self.resource_class
            Bgit::Organisations::TeamMembership
          end

          module PunditConcern
            extend ActiveSupport::Concern

            included do
              before_action :authorize_resource_class, only: [:index]
            end

            private

            def authorize_resource_class
              authorize(resource_class)
            end
          end

          include PunditConcern

          def load_collection_scope
            policy_scope(resource_class).where(team_id: current_team.id)
          end

          def load_resource_scope
            policy_scope(resource_class).where(team_id: current_team.id)
          end

          def current_team
            @current_team ||= current_frontend_auth_user.teams.find(params[:team_id])
          end
        end
      end
    end
  end
end
