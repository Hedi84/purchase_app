class CreateItemOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :item_options do |t|
      t.string :name
      t.integer :allocation
      t.string :description

      t.timestamps
    end
  end
end
