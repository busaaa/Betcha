class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :string
      t.string :admin_id
      t.string :integer

      t.timestamps
    end
  end
end
