class CreateGroupUserTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :group_user_tournaments do |t|
      t.integer :group_user_id
      t.integer :tournament_id
      t.integer :points
      t.integer :rank

      t.timestamps
    end
  end
end
