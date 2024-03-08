require 'factory_bot_rails'

FactoryBot.tap do |f|
  f.definition_file_paths << Rails.root.join(*%w(spec factories))
  f.definition_file_paths << Bgit::FrontendAuth::Engine.root.join(*%w(spec factories))
  f.factories.clear
  f.find_definitions
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
