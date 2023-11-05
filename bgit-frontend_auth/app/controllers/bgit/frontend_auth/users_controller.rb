module Bgit
  module FrontendAuth
    class UsersController < Cmor::Core::Backend::ResourcesController::Base
      include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern

      def self.resource_class
        Bgit::FrontendAuth::User
      end

      private

      def permitted_params
        params.require(:user).permit(:email, :password, :password_confirmation, :active, :approved, :confirmed)
      end
    end
  end
end
