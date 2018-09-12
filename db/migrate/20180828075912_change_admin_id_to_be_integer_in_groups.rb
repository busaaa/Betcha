class ChangeAdminIdToBeIntegerInGroups < ActiveRecord::Migration[5.2]
  def change
    change_column :groups, :admin_id, :integer
  end
end
