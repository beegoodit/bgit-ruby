module Bgit
  module FrontendAuth
    module Api
      class Engine < ::Rails::Engine
        isolate_namespace Bgit::FrontendAuth::Api
      end
    end
  end
end
