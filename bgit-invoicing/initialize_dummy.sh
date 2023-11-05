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

# Setup cors
# echo "require 'rack/cors'" >> config/initializers/cors.rb
# echo "Rails.application.config.middleware.insert_before 0, Rack::Cors do" >> config/initializers/cors.rb
# echo "  allow do" >> config/initializers/cors.rb
# echo "    origins '*'" >> config/initializers/cors.rb
# echo "    resource '*'," >> config/initializers/cors.rb
# echo "      headers: :any," >> config/initializers/cors.rb
# echo "      methods: [:get, :post, :put, :patch, :delete, :options, :head], expose: ['Content-Disposition']" >> config/initializers/cors.rb
# echo "  end" >> config/initializers/cors.rb
# echo "end" >> config/initializers/cors.rb

# Setup administrador
rails generate administrador:install

# Setup cmor_core
rails generate cmor:core:install

# Setup cmor_core_backend
rails generate cmor:core:backend:install

# Setup bgit-frontend_auth
rails bgit_frontend_auth:install:migrations
rails generate bgit:frontend_auth:install

# Setup dummy app
rails generate model Team name
sed -i "2i\  include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern" app/models/team.rb
sed -i "3i\  autocomplete scope: ->(matcher) { where(\"teams.name LIKE :term\", term: \"%#{matcher.downcase}%\") }, id_method: :id, text_method: :name" app/models/team.rb
sed -i "3i\  def human; name; end" app/models/team.rb

touch app/controllers/teams_controller.rb
echo "class TeamsController < Cmor::Core::Backend::ResourcesController::Base" >> app/controllers/teams_controller.rb
echo "  include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern" >> app/controllers/teams_controller.rb
echo "" >> app/controllers/teams_controller.rb
echo "  def self.resource_class" >> app/controllers/teams_controller.rb
echo "    Team" >> app/controllers/teams_controller.rb
echo "  end" >> app/controllers/teams_controller.rb
echo "" >> app/controllers/teams_controller.rb
echo "  private" >> app/controllers/teams_controller.rb
echo "" >> app/controllers/teams_controller.rb
echo "  def permitted_params" >> app/controllers/teams_controller.rb
echo "    params.require(:team).permit()" >> app/controllers/teams_controller.rb
echo "  end" >> app/controllers/teams_controller.rb
echo "end" >> app/controllers/teams_controller.rb
echo "" >> app/controllers/teams_controller.rb

sed -i "2i\  resources :teams do" config/routes.rb
sed -i "3i\    get :autocomplete, on: :collection" config/routes.rb
sed -i "4i\  end" config/routes.rb


# Setup bgit-invoicing
rails bgit_invoicing:install:migrations
BGIT_INVOICING_INVOICE_OWNER_FACTORY_NAME=bgit_frontend_auth_user BGIT_INVOICING_RESOURCE_OWNER_FACTORY_NAME=bgit_frontend_auth_user rails generate bgit:invoicing:install
echo "Bgit::Invoicing::Engine.load_seed" >> db/seeds.rb
sed -i "s|  config.resource_owner_autocomplete_classes = -> { {} }|  config.resource_owner_autocomplete_classes = -> { { Bgit::FrontendAuth::User => bgit_frontend_auth.url_for([:autocomplete, Bgit::FrontendAuth::User]), Team => main_app.url_for([:autocomplete, Team]) } }|g" config/initializers/bgit-invoicing.rb

# Setup database
rails db:migrate db:seed db:test:prepare
