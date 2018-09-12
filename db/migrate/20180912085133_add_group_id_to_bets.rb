class AddGroupIdToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :group_id, :integer
  end
end
