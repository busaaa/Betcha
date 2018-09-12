class ChangeRankToBeIntegerInGroupUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :group_users, :rank, :integer
   end
end
