class RemoveStringFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :string, :string
  end
end
