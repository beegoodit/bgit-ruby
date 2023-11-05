class RenameFrontendAuthUsers < ActiveRecord::Migration[7.0]
  def change
    rename_table :frontend_auth_users, :bgit_frontend_auth_users
  end
end
