module Bgit
  module Invoicing
    module Frontend
      class InvoicesController < Bgit::Invoicing::Frontend::ApplicationController
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::RestActionsConcern
        include Rao::ResourcesController::SortingConcern

        helper Rao::Component::ApplicationHelper

        helper_method :available_rest_actions, :add_order_scope

        def self.resource_class
          Bgit::Invoicing::Invoice
        end

        def index
          authorize(resource_class)
          super
        end

        def show
          authorize(@resource)
          super
        end

        private

        def available_rest_actions
          [:index, :show]
        end

        def load_collection_scope
          Bgit::Invoicing::Invoice.owned_by_any(*current_owners).order(year: :desc, month: :desc)
        end

        def load_resource_scope
          Bgit::Invoicing::Invoice.owned_by_any(*current_owners)
        end

        def current_owners
          # check if current_frontend_auth_user responds to :teams
          if current_frontend_auth_user.respond_to?(:teams)
            [current_frontend_auth_user, current_frontend_auth_user.teams]
          else
            [current_frontend_auth_user]
          end
        end
      end
    end
  end
end
