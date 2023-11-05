module Bgit
  module FrontendAuth
    module Frontend
      class Engine < ::Rails::Engine
        isolate_namespace Bgit::FrontendAuth::Frontend
      end
    end
  end
end
