      require "bgit/frontend_auth/api/spec_helpers/request"
      
      RSpec.configure do |config|
        config.include Bgit::FrontendAuth::Api::SpecHelpers::Request, type: :request
      end