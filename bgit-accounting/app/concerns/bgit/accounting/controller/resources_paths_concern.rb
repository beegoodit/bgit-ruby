module Bgit
  module Accounting
    module Controller
      module ResourcesPathsConcern
        extend ActiveSupport::Concern

        # accounts
        def keepr_accounts_path(*)
          accounts_path(*)
        end

        def keepr_account_path(*)
          account_path(*)
        end

        def edit_keepr_account_path(*)
          edit_account_path(*)
        end

        # journals
        def keepr_journals_path(*)
          journals_path(*)
        end

        def keepr_journal_path(*)
          journal_path(*)
        end

        def edit_keepr_journal_path(*)
          edit_journal_path(*)
        end

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
