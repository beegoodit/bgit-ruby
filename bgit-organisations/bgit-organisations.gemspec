$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require_relative "lib/bgit/organisations/version"

Gem::Specification.new do |spec|
  spec.name = "bgit-organisations"
  spec.version = Bgit::Organisations::VERSION
  spec.authors = ["BeeGood IT"]
  spec.email = ["info@beegoodit.de"]
  spec.homepage = "https://hosting.beegoodit.de"
  spec.summary = "BeeGood IT End Team Frontend Auth Module"
  spec.description = "Provides end team frontend authentication."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,spec/factories}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4.3"
  spec.add_dependency "bgit-frontend_auth"
  spec.add_dependency "cmor-core-backend"
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
  spec.add_development_dependency "rao-shoulda_matchers"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "standardrb"
  spec.add_development_dependency "webpacker"
end
