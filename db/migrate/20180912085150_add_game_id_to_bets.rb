class AddGameIdToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :game_id, :integer
  end
end
