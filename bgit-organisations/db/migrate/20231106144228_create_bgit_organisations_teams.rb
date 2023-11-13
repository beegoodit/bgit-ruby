class CreateBgitOrganisationsTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_organisations_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
