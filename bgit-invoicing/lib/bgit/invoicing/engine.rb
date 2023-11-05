module Bgit
  module Invoicing
    class Engine < ::Rails::Engine
      isolate_namespace Bgit::Invoicing

      config.generators do |g|
        g.test_framework :rspec, view_specs: false, helper_specs: false
        g.fixture_replacement :factory_bot, dir: "spec/factories"
      end
    end
  end
end
