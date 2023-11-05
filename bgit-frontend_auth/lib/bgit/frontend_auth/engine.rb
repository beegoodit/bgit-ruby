module Bgit
  module FrontendAuth
    class Engine < ::Rails::Engine
      isolate_namespace Bgit::FrontendAuth
    end
  end
end
