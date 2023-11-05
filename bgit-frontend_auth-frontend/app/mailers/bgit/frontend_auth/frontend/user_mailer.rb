module Bgit
  module FrontendAuth
    module Frontend
      class UserMailer < ::Bgit::FrontendAuth::Frontend::Configuration.base_mailer.constantize
        default from: ::Bgit::FrontendAuth::Frontend::Configuration.email_from_address

        def password_reset_email(user, host, application_name = nil)
          @host = host
          @user = user
          @application_name = application_name || Bgit::FrontendAuth::Frontend::Configuration.application_name
          mail(to: @user.email)
        end
      end
    end
  end
end
