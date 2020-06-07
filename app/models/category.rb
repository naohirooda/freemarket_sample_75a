class Category < ApplicationRecord
  has_ancestry
  has_many :items
 
  scope :children, -> (child){ where(ancestry: child.ancestry) }
  scope :grandchildren, -> (grandchild){ where(ancestry: grandchild.ancestry) }
end
