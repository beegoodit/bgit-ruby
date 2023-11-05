$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require_relative "lib/bgit/lexoffice/version"

Gem::Specification.new do |spec|
  spec.name = "bgit-lexoffice"
  spec.version = Bgit::Lexoffice::VERSION
  spec.authors = ["BeeGood IT"]
  spec.email = ["info@beegoodit.de"]
  spec.homepage = "https://lexoffice.beegoodit.de"
  spec.summary = "Beegood IT Lexoffice Module"
  spec.description = "Provides monitoring for dokku powered hosts."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,spec/factories}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4.3"
  spec.add_dependency "administrador", ">= 0.0.30.pre"
  spec.add_dependency "cmor-core-backend", ">= 0.0.60.pre"
  spec.add_dependency "httparty"
  spec.add_dependency "rao-service"
  spec.add_dependency "rao-shoulda_matchers"
  spec.add_dependency "simple_form-polymorphic_associations"
  spec.add_dependency "turbo-rails"
  spec.add_dependency "pundit"
  spec.add_dependency "bgit-invoicing"
  spec.add_dependency "lexoffice_client-rails"
  spec.add_development_dependency "bootsnap"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-standardrb"
  spec.add_development_dependency "puma"
  spec.add_development_dependency "rails-dummy"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "standardrb"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "webpacker"
  spec.add_development_dependency "rails-erd"
  spec.add_development_dependency "json_seeds-rails"
  spec.add_development_dependency "i18n-debug"
end
