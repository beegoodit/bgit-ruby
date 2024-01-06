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

# Setup user model as bank account owner
rails g model User email:string

sed -i "2i\  include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern" app/models/user.rb
sed -i "3i\  autocomplete scope: ->(matcher) { where(\"users.email LIKE :term\", term: \"%#{matcher.downcase}%\") }, id_method: :id, text_method: :email" app/models/user.rb
sed -i "3i\  def human; email; end" app/models/user.rb

touch app/controllers/users_controller.rb

echo "class UsersController < Cmor::Core::Backend::ResourcesController::Base" >> app/controllers/users_controller.rb
echo "  include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern" >> app/controllers/users_controller.rb
echo "" >> app/controllers/users_controller.rb
echo "  def self.resource_class" >> app/controllers/users_controller.rb
echo "    User" >> app/controllers/users_controller.rb
echo "  end" >> app/controllers/users_controller.rb
echo "" >> app/controllers/users_controller.rb
echo "  private" >> app/controllers/users_controller.rb
echo "" >> app/controllers/users_controller.rb
echo "  def permitted_params" >> app/controllers/users_controller.rb
echo "    params.require(:user).permit()" >> app/controllers/users_controller.rb
echo "  end" >> app/controllers/users_controller.rb
echo "end" >> app/controllers/users_controller.rb
echo "" >> app/controllers/users_controller.rb

sed -i "2i\  resources :users do" config/routes.rb
sed -i "3i\    get :autocomplete, on: :collection" config/routes.rb
sed -i "4i\  end" config/routes.rb

# Setup administrador
rails generate administrador:install

# Setup cmor-core
rails generate cmor:core:install

# Setup cmor-core-backend
rails generate cmor:core:backend:install

# Setup keepr
rails generate keepr:migration

# Setup bgit-accounting
rails generate bgit:accounting:install
rails bgit_accounting:install:migrations

# Setup database
rails db:migrate db:seed db:test:prepare
