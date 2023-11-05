module Bgit
  module FrontendAuth
    class UserSession < Authlogic::Session::Base
      params_key "user_api_key"
      generalize_credentials_error_messages true
    end
  end
end
