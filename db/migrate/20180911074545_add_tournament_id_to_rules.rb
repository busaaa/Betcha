class AddTournamentIdToRules < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :tournament_id, :integer
  end
end
