# README
## how to use GitHub Desktop

## users_table
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique:true|
|email|string|null: false, unique:true|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_katakana|string|null: false|
|last_name_katakana|string|null: false|

### Association
- belongs_to :address
- has_many :cards
- has_many :comments
- has_many :items

## addresses_table
|Column|Type|Options|
|------|----|-------|
|user_id|refarences|null: false, foreign_key: true|
|post_code|string|null: false|
|preficture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string||
|phone_number|string||

### Association
- has_many :users

## cards_table
|Column|Type|Options|
|------|----|-------|
|user_id|refarences|null: false, foreign_key: true|
|card_id|string|null: false|
|custmer_id|string|null: false|
|card_number|string|null: false, unique:true|

### Association
- belongs_to :user

## comments_table
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## items_table
|Column|Type|Options|
|------|----|-------|
|item_name|string|null: false, add_index|
|item_explanation|text|null: false|
|item_image|text|null: false|
|category_id|references|null: false, foreign_key: true|
|brand_name|string||
|item_status|integer|null: false|
|auction_status|string|null: false|
|delivery_fee|integer|null: false|
|shipping_origin|string|null: false|
|days_until_shipping|string|null: false|
|exhibition_price|integer|null: false|

### Association
- belongs_to :user
- has_many :comments
- has_many :categorys, through: :item_categorys
- has_many :item_categorys

## item_categorys_table
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :category

## categorys_table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique:true|
|ancestry|string|add_index|

### Association
- has_many :items, through:  :item_categorys
- has_many :item_categorys