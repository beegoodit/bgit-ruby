Bgit::FrontendAuth::Api.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = "<%= base_controller_class_name %>"
  #
  config.base_controller = "<%= base_controller_class_name %>"

  # Enable or disable user registrations
  #
  # Default: config.enable_registrations = false
  #
  config.enable_registrations = false
end
