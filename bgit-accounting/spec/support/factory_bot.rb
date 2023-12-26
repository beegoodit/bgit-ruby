require "factory_bot"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

keepr_gem = Gem::Specification.find_by_name("keepr")
keepr_root = keepr_gem.gem_dir

FactoryBot.tap do |f|
  f.factories.clear
  f.definition_file_paths += [
    File.join(keepr_root, *%w[spec factories]),
    Bgit::Accounting::Engine.root.join(*%w[spec factories]),
    Rails.root.join(*%w[spec factories])
  ]
  f.find_definitions
end
