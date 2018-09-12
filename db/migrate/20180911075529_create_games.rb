class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :tournament_id
      t.string :team1
      t.string :team2
      t.datetime :start_time
      t.integer :team1_result
      t.integer :team2_result
      t.string :penalty

      t.timestamps
    end
  end
end
