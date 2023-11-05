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

# Setup bgit-frontend_auth
rails bgit_frontend_auth:install:migrations
rails generate bgit:frontend_auth:install

# Add Team model
rails generate model Team name:string
# Add human method to model
sed -i "s|class Team < ApplicationRecord|class Team < ApplicationRecord\n  def human\n    name\n  end|g" app/models/team.rb

# add User model
rails generate model User name:string
# add human method to model
sed -i "s|class User < ApplicationRecord|class User < ApplicationRecord\n  def human\n    name\n  end|g" app/models/user.rb
# add lexoffice_contact association to model
sed -i "s|class User < ApplicationRecord|class User < ApplicationRecord\n  has_one :lexoffice_contact, class_name: 'Bgit::Lexoffice::Contact', as: :contactable, dependent: :destroy|g" app/models/user.rb

# Setup bgit-invoicing
rails bgit_invoicing:install:migrations
rails generate bgit:invoicing:install
echo "Bgit::Invoicing::Engine.load_seed" >> db/seeds.rb

# Setup bgit-lexoffice
rails bgit_lexoffice:install:migrations
rails generate bgit:lexoffice:install
echo "Bgit::Lexoffice::Engine.load_seed" >> db/seeds.rb

# Setup lexoffice_client-rails
rails generate lexoffice_client:rails:install

# Setup database
rails db:migrate db:seed db:test:prepare
