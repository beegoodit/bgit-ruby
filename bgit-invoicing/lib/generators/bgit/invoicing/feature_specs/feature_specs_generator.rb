module Bgit
  module Invoicing
    class FeatureSpecsGenerator < Rails::Generators::Base
      desc "Generates feature specs"

      source_root Bgit::Invoicing::Engine.root.join("spec")

      def generate_feature_specs
        directory "features", "spec/features"
      end
    end
  end
end
