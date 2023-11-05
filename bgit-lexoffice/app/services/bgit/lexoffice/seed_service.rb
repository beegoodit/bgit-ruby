module Bgit
  module Lexoffice
    class SeedService < JsonSeeds::SeedService::Base
      class Result < JsonSeeds::SeedService::Result::Base
      end

      private

      def model_name_map
        @model_name_map ||= {
          "contact" => "Bgit::Lexoffice::Contact",
          "polymorphic:contact:contactable:team" => {class_name: team_class_name, as: :contactable}
        }
      end

      def team_class_name
        @team_class_name ||= Bgit.const_defined?(:Hosting) ? "Bgit::Hosting::Team" : "Team"
      end

      def seed_path
        @seed_path ||= Bgit::Lexoffice::Engine.root.join("db", "seeds")
      end

      def before_import
        unless Bgit.const_defined?(:Hosting)
          say "Creating default teams" do
            ["Art der Gestaltung", "DECHEMA e.V.", "DVVF e.V.", "1. TFC Frankfurt", "BeeGood IT"].each do |name|
              say "Creating team #{name}" do
                Team.create!(name: name)
              end
            end
          end

          # say "Creating default frontend auth users" do
          #   ["user@domain.local"].each do |email|
          #     say "Creating frontend auth user #{email}" do
          #       Bgit::FrontendAuth::User.create!(email: email, password: "password", password_confirmation: "password")
          #     end
          #   end
          # end
        end
      end
    end
  end
end
