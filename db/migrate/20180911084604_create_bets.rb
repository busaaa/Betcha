class CreateBets < ActiveRecord::Migration[5.2]
  def change
    create_table :bets do |t|
      t.boolean :changable
      t.integer :team1_bet
      t.integer :team2_bet
      t.string :penalty
      t.references :betable, polymorphic: true

      t.timestamps
    end
  end
end
