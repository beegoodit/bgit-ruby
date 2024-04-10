module Bgit
  module Accounting
    module Contacts
      class AddressesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Contacts::Address
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:contacts_address).permit
        end
      end
    end
  end
end
