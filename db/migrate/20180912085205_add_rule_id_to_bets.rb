class AddRuleIdToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :rule_id, :integer
  end
end
