module Bgit
  module Lexoffice
    module Invoice::Document
      class ReadService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :lexoffice_document
        end

        attr_accessor :invoice_id, # Bgit::Lexoffice::Invoice
          :lexoffice_document # LexofficeClient::Document

        validates :invoice, presence: true

        def invoice
          @invoice ||= Bgit::Lexoffice::Invoice.find_by(lexoffice_id: invoice_id)
        end

        def autosave=(value)
          @options[:autosave] = ActiveRecord::Type::Boolean.new.cast(value)
        end

        private

        def _perform
          read_document_from_lexoffice!
        end

        def read_document_from_lexoffice!
          result = LexofficeClient::Invoice::Document::ReadService.call(invoice_id: invoice.lexoffice_id)
          if result.success?
            @result.lexoffice_document = result.document
          else
            errors.add(:read_document_from_lexoffice, result.errors.full_messages.to_sentence)
          end
        end

        def attach_document_to_invoice!
          string_io = @result.lexoffice_document.to_string_io
          invoice.lexoffice_document.attach(io: string_io, filename: string_io.original_filename, content_type: string_io.content_type)
        end

        def save
          attach_document_to_invoice!
        end
      end
    end
  end
end
