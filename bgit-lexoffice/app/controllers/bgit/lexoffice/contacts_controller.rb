module Bgit
  module Lexoffice
    class ContactsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Lexoffice::Contact
      end

      private

      def permitted_params
        params.require(:contact).permit(:lexoffice_id, :contactable_id, :contactable_type)
      end
    end
  end
end
