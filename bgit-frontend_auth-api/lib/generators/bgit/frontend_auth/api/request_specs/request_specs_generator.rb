module Bgit
  module FrontendAuth
    module Api
      class RequestSpecsGenerator < Rails::Generators::Base
        desc "Generates request specs"

        source_root Bgit::FrontendAuth::Api::Engine.root.join("spec")

        def generate_feature_specs
          directory "requests", "spec/requests"
        end
      end
    end
  end
end
