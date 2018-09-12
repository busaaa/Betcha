class RemoveBetableTypeFromBets < ActiveRecord::Migration[5.2]
  def change
    remove_column :bets, :betable_type, :string
  end
end
