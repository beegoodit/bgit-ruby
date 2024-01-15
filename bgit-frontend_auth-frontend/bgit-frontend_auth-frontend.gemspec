$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "bgit/frontend_auth/frontend/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "bgit-frontend_auth-frontend"
  spec.version     = Bgit::FrontendAuth::Frontend::VERSION
  spec.authors     = ["BeeGood IT"]
  spec.email       = ["it@beegoodit.de"]
  spec.homepage    = "https://www.beegoodit.de"
  spec.summary     = "BeeGood IT End User Authentication Frontend Module."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.required_ruby_version = '>= 3.2.2'

  spec.add_dependency "rails", ">= 7.0.4.3"
  spec.add_dependency "bgit-frontend_auth"
  spec.add_dependency "haml-rails"
  spec.add_dependency "rao-component", ">= 0.0.52.pre"
  spec.add_dependency "rao-resources_controller"
  spec.add_dependency "rao-service"
  spec.add_dependency "route_translator"
  spec.add_dependency "simple_form"
  spec.add_dependency "turbo-rails"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "rspec-rails", ">= 4.0.1"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'rails-dummy'
  spec.add_development_dependency 'bootsnap'
  spec.add_development_dependency 'webpacker'
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'rails-i18n'
  spec.add_development_dependency 'sprockets-rails'
  spec.add_development_dependency 'puma'
end
