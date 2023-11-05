module Bgit
  module Lexoffice
    module Document
      class ReadServicesController < Cmor::Core::Backend::ServiceController::Base
        def self.service_class
          Bgit::Lexoffice::Invoice::Document::ReadService
        end

        def self.engine_class
          Bgit::Lexoffice::Engine
        end

        def create
          if ActiveRecord::Type::Boolean.new.cast(params.dig(:invoice_document_read_service, :download))
            @result = execute_service
            if @result.success?
              send_data @result.lexoffice_document.to_string_io.read, filename: @result.lexoffice_document.to_string_io.original_filename, type: @result.lexoffice_document.to_string_io.content_type, disposition: "attachment"
            else
              flash.now[:notice] = success_message if success_message.present?
              render :create
            end
          else
            super
          end
        end

        private

        def initialize_service_for_create
          super
          @service.invoice_id = invoice.lexoffice_id
          @service.autosave = params.dig(:invoice_document_read_service, :autosave)
        end

        def invoice
          @invoice ||= Bgit::Lexoffice::Invoice.find(params[:invoice_id])
        end

        def permitted_params
          params.fetch(:document_read_service, {}).permit(:download, :autosave)
        end
      end
    end
  end
end
