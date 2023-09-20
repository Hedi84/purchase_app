class AddPurchaseIdToItems < ActiveRecord::Migration[7.0]
  def change
    change_table :items do |t|
      t.references :purchase, null: false, foreign_key: true
    end
  end
end
