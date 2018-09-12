class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.string :group_id
      t.string :integer
      t.string :user_id
      t.string :integer
      t.string :points
      t.string :integer
      t.string :rank
      t.string :integer

      t.timestamps
    end
  end
end
