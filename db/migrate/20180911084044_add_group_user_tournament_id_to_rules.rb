class AddGroupUserTournamentIdToRules < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :group_user_tournament_id, :integer
  end
end
