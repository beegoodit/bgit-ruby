Bgit::FrontendAuth::Frontend.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = "<%= base_controller_class_name %>"
  #
  config.base_controller = "<%= base_controller_class_name %>"

  # Set the base mailer for the user mailer
  #
  # Default: config.base_mailer = "::ApplicationMailer"
  #
  config.base_mailer = "::ApplicationMailer"

  # default: config.enable_registrations = true
  #
  config.enable_registrations = true
  
  # default: config.allow_users_to_destroy_self = true
  #
  config.allow_users_to_destroy_self = true
  
  # default: config.email_from_address = "authentication@domain.local"
  #
  config.email_from_address = "authentication@domain.local"
  
  # default: config.application_name = "Application Name"
  #
  config.application_name = "Application Name"

  # Where to redirect to after successful login.
  #
  # Default: config.after_sign_in_url = -> { main_app.root_path }
  #
  config.after_sign_in_url = -> { main_app.root_path }

  # Where to redirect to after successful logout.
  #
  # Default: config.after_sign_out_url = -> { main_app.root_path }
  #
  config.after_sign_out_url = -> { main_app.root_path }
end
