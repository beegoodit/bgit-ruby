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

# Setup dummy app
rails generate model User email:string
sed -i "2i\  include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern" app/models/user.rb
sed -i "3i\  autocomplete scope: ->(matcher) { where(\"users.email LIKE :term\", term: \"%#{matcher.downcase}%\") }, id_method: :id, text_method: :email" app/models/user.rb
sed -i "4i\  has_many :apps, as: :owner, class_name: 'Bgit::Organisations::App', inverse_of: :owner" app/models/user.rb
sed -i "5i\  has_many :team_memberships, class_name: 'Bgit::Organisations::TeamMembership', foreign_key: :member_id, inverse_of: :member, dependent: :destroy" app/models/user.rb
sed -i "6i\  def human; email; end" app/models/user.rb

rails g controller Users
sed -i "2i\  include Rao::ResourcesController::ResourcesConcern" app/controllers/users_controller.rb
sed -i "3i\  include Rao::ResourcesController::RestActionsConcern" app/controllers/users_controller.rb
sed -i "4i\  include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern" app/controllers/users_controller.rb
sed -i "5i\  def self.resource_class" app/controllers/users_controller.rb
sed -i "6i\    User" app/controllers/users_controller.rb
sed -i "7i\  end" app/controllers/users_controller.rb

sed -i "2i\  resources :users do" config/routes.rb
sed -i "3i\    get :autocomplete, on: :collection" config/routes.rb
sed -i "4i\  end" config/routes.rb

rails g controller Frontend
sed -i "2i\  include Bgit::FrontendAuth::Frontend::Controller::CurrentUserConcern" app/controllers/frontend_controller.rb
sed -i "2i\  include Bgit::FrontendAuth::Frontend::Controller::RedirectBackConcern" app/controllers/frontend_controller.rb
sed -i "3i\  before_action :authenticate_frontend_auth_user!" app/controllers/frontend_controller.rb

sed -i "2i\  root to: proc { [200, {}, ['OK']] }" config/routes.rb

# Setup bgit-organisations
rails bgit_organisations:install:migrations
rails generate bgit:organisations:install

# Setup frontend_auth
rails generate bgit:frontend_auth:install
rails bgit_frontend_auth:install:migrations

# Setup bgit-frontend_auth-frontend
rails generate bgit:frontend_auth:frontend:install

# Setup bgit-organisations-frontend
BGIT_HOSTING_FRONTEND_BASE_CONTROLLER_CLASS_NAME="::FrontendController" rails generate bgit:organisations:frontend:install

# Setup database
rails db:migrate db:test:prepare