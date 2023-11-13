class CreateBgitOrganisationsTeamMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_organisations_team_memberships do |t|
      t.references :member, null: false, foreign_key: {to_table: Bgit::Organisations::Configuration.team_membership_member_foreign_key_to_table}
      t.references :team, null: false, foreign_key: {to_table: :bgit_organisations_teams}

      t.timestamps
    end
  end
end
