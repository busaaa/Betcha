class RemoveIntegerFromGroupUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_users, :integer, :string
  end
end
