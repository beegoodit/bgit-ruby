module Bgit
  module Organisations
    module Frontend
      class Engine < ::Rails::Engine
        isolate_namespace Bgit::Organisations::Frontend
      end
    end
  end
end
