module Bgit
  module Accounting
    module Contacts
      class PeopleController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Contacts::Person
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:contacts_person).permit
        end
      end
    end
  end
end
