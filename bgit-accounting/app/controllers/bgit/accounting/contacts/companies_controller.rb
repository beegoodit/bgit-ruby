module Bgit
  module Accounting
    module Contacts
      class CompaniesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Contacts::Company
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:contacts_company).permit
        end
      end
    end
  end
end
