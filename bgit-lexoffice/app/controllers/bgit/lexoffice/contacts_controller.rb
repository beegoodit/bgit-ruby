module Bgit
  module Lexoffice
    class ContactsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Lexoffice::Contact
      end

      private

      # Accept setting the contactable via params. This is needed to populate
      # the contactable when linking to this form.
      def initialize_resource
        super
        if params.dig(:contact, :contactable_type).present? && params.dig(:contact, :contactable_id).present?
          @resource.contactable = params[:contact][:contactable_type].constantize.find(params[:contact][:contactable_id])
        end
      end


      def permitted_params
        params.require(:contact).permit(:lexoffice_id, :contactable_id, :contactable_type)
      end
    end
  end
end
