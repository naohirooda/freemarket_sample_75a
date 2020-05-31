class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string      :name,                 null:false
      t.text        :item_explanation,     null:false
      t.references  :category,             foreign_key: true
      t.string      :brand_name
      t.integer     :item_status,          null:false
      t.integer     :auction_status,       null:false,_suffix: true, default:"1"
      t.integer     :delivery_fee,         null:false,_suffix: true
      t.integer     :shipping_origin,      null:false,_suffix: true
      t.integer     :days_until_shipping,  null:false,_suffix: true
      t.integer     :exhibition_price,     null:false,_suffix: true
      t.timestamps
    end
  end
end
