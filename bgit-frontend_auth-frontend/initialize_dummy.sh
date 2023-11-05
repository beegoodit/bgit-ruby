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

# Setup rails-i18n
sed -i "18irequire 'rails-i18n'" config/application.rb

# Setup asset pipeline
sed -i "18irequire 'sprockets/rails'" config/application.rb

# Raise unpermitted params in test and development environments
echo "$(awk 'NR==10{print "  config.action_controller.action_on_unpermitted_parameters = :raise"}1' config/environments/development.rb)" > config/environments/development.rb
echo "$(awk 'NR==10{print "  config.action_controller.action_on_unpermitted_parameters = :raise"}1' config/environments/test.rb)" > config/environments/test.rb

# Setup dummy ap
sed -i "2i  root to: proc { [200, {}, ['Root']] }" config/routes.rb

# Add layout
cat <<EOT > app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
  <head>
    <title>Dummy</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <% flash.each do |type, msg| %>
      <div>
        <%= msg %>
      </div>
    <% end %>

    <%= yield %>
  </body>
</html>
EOT

# Setup frontend_auth
rails generate bgit:frontend_auth:install
rails bgit_frontend_auth:install:migrations

# Setup frontend_auth-frontend
rails generate bgit:frontend_auth:frontend:install

# Setup database
rails db:migrate && rails db:test:prepare
