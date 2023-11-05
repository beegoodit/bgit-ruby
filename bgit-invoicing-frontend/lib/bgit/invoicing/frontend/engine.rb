module Bgit
  module Invoicing
    module Frontend
      class Engine < ::Rails::Engine
        isolate_namespace Bgit::Invoicing::Frontend
      end
    end
  end
end
