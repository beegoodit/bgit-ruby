module Bgit
  module Lexoffice
    module Voucher
      class ListServicesController < Cmor::Core::Backend::ServiceController::Base
        def self.service_class
          LexofficeClient::Voucher::ListService
        end

        def self.engine_class
          Bgit::Lexoffice::Engine
        end

        private

        def permitted_params
          params.require(:voucher_list_service).permit(:type, :status)
        end
      end
    end
  end
end
