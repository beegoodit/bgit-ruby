module Bgit
  module Organisations
    module Frontend
      class HomeController < Bgit::Organisations::Frontend::ApplicationController
        def index
          # authorize headless
          authorize(self.class.name.gsub("Controller", "").underscore.split("/").map(&:to_sym))
        end
      end
    end
  end
end
