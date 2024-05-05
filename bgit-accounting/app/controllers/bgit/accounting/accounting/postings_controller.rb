module Bgit
  module Accounting
    module Accounting
      class PostingsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::Posting
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        def self.available_rest_actions
          super - %i[new create edit update]
        end

        private

        def permitted_params
          params.require(:accounting_posting).permit
        end
      end
    end
  end
end
