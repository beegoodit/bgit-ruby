#!/bin/bash

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true bundle exec rake dummy:app

if [ ! -d "spec/dummy/config" ]; then exit 1; fi

# Cleanup
rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

cd spec/dummy

# Use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Setup webpacker
rails webpacker:install

# Setup simple form
rails generate simple_form:install --bootstrap

# Setup active storage
rails active_storage:install

# Setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup administrador
rails generate administrador:install

# Setup cmor_core
rails generate cmor:core:install

# Setup cmor_core_backend
rails generate cmor:core:backend:install

# Setup dummy app
rails g controller Frontend
sed -i "2i\  include Bgit::FrontendAuth::Frontend::Controller::CurrentUserConcern" app/controllers/frontend_controller.rb
sed -i "2i\  include Bgit::FrontendAuth::Frontend::Controller::RedirectBackConcern" app/controllers/frontend_controller.rb
sed -i "3i\  before_action :authenticate_frontend_auth_user!" app/controllers/frontend_controller.rb

sed -i "2i\  root to: proc { [200, {}, ['OK']] }" config/routes.rb

# Setup bgit-invoicing
rails bgit_invoicing:install:migrations
rails generate bgit:invoicing:install

# Setup bgit-frontend_auth
rails generate bgit:frontend_auth:install
rails bgit_frontend_auth:install:migrations

# Setup bgit-frontend_auth-frontend
rails generate bgit:frontend_auth:frontend:install

# Setup bgit-invoicing-frontend
BGIT_INVOICING_FRONTEND_BASE_CONTROLLER_CLASS_NAME="::FrontendController" rails generate bgit:invoicing:frontend:install

# Setup database
rails db:migrate db:test:prepare