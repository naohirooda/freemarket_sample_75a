class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :exhibition_price
      t.integer :auction_status, null: false, default: "1"
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :items, :name
  end
end
