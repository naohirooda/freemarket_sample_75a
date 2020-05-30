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
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|

### Association
- has_one :address,　dependent: :destroy
- has_many :cards, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :items, dependent: :destroy

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
- belongs_to :user

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
|name|string|null: false, add_index|
|explanation|text|null: false|
|category_id|references|null: false, foreign_key: true|
|brand_name|string||
|item_status|integer|null: false|
|auction_status|integer|null: false|
|delivery_fee|integer|null: false|
|shipping_origin|integer|null: false|
|days_until_shipping|integer|null: false|
|exhibition_price|integer|null: false|

### Association
- belongs_to :user
- has_many :comments, dependent: :destroy
- has_many :images, dependent: :destroy
- belongs_to :category
- has_many :item_categorys

## images_table
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_id|references|null:false, foreign_key: true|

### Association
- belongs_to :item

## categorys_table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|add_index|

### Association
- has_ancestory
- has_many :items