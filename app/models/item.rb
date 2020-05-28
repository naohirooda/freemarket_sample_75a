class Item < ApplicationRecord
  belongs_to :category

  validates :item_name, presence: true
  validates :category_id, presence: true, allow_blank: true
end
