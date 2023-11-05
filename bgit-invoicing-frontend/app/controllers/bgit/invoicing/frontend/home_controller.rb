module Bgit
  module Invoicing
    module Frontend
      class HomeController < Bgit::Invoicing::Frontend::ApplicationController
        def index
          # authorize headless
          authorize(self.class.name.gsub("Controller", "").underscore.split("/").map(&:to_sym))
        end
      end
    end
  end
end
