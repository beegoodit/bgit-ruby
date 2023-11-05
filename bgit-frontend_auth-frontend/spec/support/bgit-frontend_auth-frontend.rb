require 'bgit/frontend_auth/frontend/spec_helpers/feature'

RSpec.configure do |config|
  config.include Bgit::FrontendAuth::Frontend::SpecHelpers::Feature, type: :feature
  config.include Bgit::FrontendAuth::Frontend::SpecHelpers::Feature, type: :system
end
