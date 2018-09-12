class ChangePointsToBeIntegerInGroupUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :group_users, :points, :integer
  end
end
