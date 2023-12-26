module Bgit
  module Accounting
    module Controller
      module ResourcesPathsConcern
        extend ActiveSupport::Concern

        private

        def after_create_location
          resource_path(@resource)
        end

        def after_update_location
          resource_path(@resource)
        end

        def after_destroy_location
          collection_path
        end
      end
    end
  end
end
