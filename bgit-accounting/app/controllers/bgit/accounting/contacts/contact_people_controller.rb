module Bgit
  module Accounting
    module Contacts
      class ContactPeopleController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Contacts::ContactPerson
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:contacts_contact_person).permit
        end
      end
    end
  end
end
