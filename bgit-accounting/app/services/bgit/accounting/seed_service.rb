module Bgit
  module Accounting
    class SeedService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :chart_of_accounts, :groups, :accounts
      end

      private

      def seed_path
        @seed_path ||= Bgit::Accounting::Engine.root.join("db", "seeds")
      end

      def _perform
        @result.groups = []
        @result.accounts = []
        @result.chart_of_accounts = parse_chart_of_accounts!
        build_chart_of_accounts!
      end

      def save
        say "Saving #{@result.groups.size} groups" do
          ActiveRecord::Base.transaction do
            @result.groups.map(&:save!)
            @result.accounts.map(&:save!)
          end
        end
      end

      def chart_of_accounts_file_pathname
        seed_path.join("skr42.json")
      end

      def parse_chart_of_accounts!
        say "Parsing chart of accounts file #{chart_of_accounts_file_pathname}" do
          JSON.parse(File.read(chart_of_accounts_file_pathname.to_s))
        end
      end

      def build_chart_of_accounts!
        say "Building chart of accounts" do
          @result.chart_of_accounts["groups"].collect do |group|
            build_group(group)
          end
        end
      end

      def build_account(group, attributes)
        say "Creating account #{attributes["number"]} - #{attributes["name"]}" do
          @result.accounts << Keepr::Account.new(attributes).tap { |account| account.keepr_group = group }
        end
      end

      def build_group(attributes, parent_group = nil)
        name = [attributes["number"], attributes["name"]].compact.join(" - ")
        say "Creating group #{name}" do
          Keepr::Group.new(name: name, target: attributes["target"]).tap do |group|
            group.parent = parent_group
            attributes["accounts"]&.each do |account|
              build_account(group, account)
            end
            attributes["groups"]&.each do |sub_group|
              build_group(sub_group, group)
            end
            @result.groups << group
          end
        end
      end
    end
  end
end
