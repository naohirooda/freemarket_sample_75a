class Item < ApplicationRecord
  # belongs_to :user
  has_many :images
  belongs_to :category

  accepts_nested_attributes_for :images, allow_destroy: true
  validates :name,                         presence: true,    length: { maximum: 40 } 
  validates :item_explanation,             presence: true,    length: { maximum: 1000 } 
  validates :category,                     presence: true
  validates :item_status,                  presence: true
  validates :auction_status,               presence: true
  validates :delivery_fee,                 presence: true
  validates :shipping_origin,              presence: true
  validates :days_until_shipping,          presence: true
  validates :exhibition_price,             presence: true
  validates_associated :images
  validates :images,                      presence: true
  enum item_status: {新品未、使用: 1, 未使用に近い: 2,目立った傷や汚れなし: 3,やや傷や汚れあり: 4,傷や汚れあり: 5,全体的に状態が悪い: 6}
  enum auction_status: {出品中: 1, 売り切れ: 2}
  enum delivery_fee: {送料込み（出品者負担）: 1, 着払い（購入者負担）: 2}
  enum days_until_shipping: {１〜２日で発送: 1, ２〜３日で発送: 2, ４〜７日で発送: 2}
end
