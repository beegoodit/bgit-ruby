module Bgit
  module Accounting
    class Engine < ::Rails::Engine
      isolate_namespace Bgit::Accounting

      config.to_prepare do
        Keepr::Account.send(:include, Bgit::Accounting::Model::KeeprAccountExtensionsConcern)
        Keepr::Posting.send(:include, Bgit::Accounting::Model::KeeprPostingExtensionsConcern)
      end

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot, dir: "spec/factories"
      end
    end
  end
end
