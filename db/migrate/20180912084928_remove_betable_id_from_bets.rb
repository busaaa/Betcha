class RemoveBetableIdFromBets < ActiveRecord::Migration[5.2]
  def change
    remove_column :bets, :betable_id, :integer
  end
end
