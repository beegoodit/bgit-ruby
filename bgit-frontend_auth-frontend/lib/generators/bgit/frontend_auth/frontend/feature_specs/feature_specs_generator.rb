module Bgit
  module FrontendAuth
    module Frontend
      class FeatureSpecsGenerator < Rails::Generators::Base
        desc "Generates feature specs"

        source_root Bgit::FrontendAuth::Frontend::Engine.root.join("spec")

        def generate_feature_specs
          directory "features", "spec/features"
          template "support/bgit-frontend_auth-frontend.rb", "spec/support/bgit-frontend_auth-frontend.rb"
        end
      end
    end
  end
end
