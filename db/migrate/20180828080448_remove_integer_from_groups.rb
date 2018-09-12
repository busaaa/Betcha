class RemoveIntegerFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :integer, :string
  end
end
