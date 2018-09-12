class CreateRules < ActiveRecord::Migration[5.2]
  def change
    create_table :rules do |t|
      t.string :name
      t.integer :perfect
      t.integer :result
      t.integer :one_perfect
      t.integer :nothing
      t.string :penalty
      t.boolean :default

      t.timestamps
    end
  end
end
