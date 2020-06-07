FactoryBot.define do
  factory :item do
    id                    {1}
    name                  {"パンツ"}
    item_explanation      {"メンズパンツです"}
    # user
    brand_name            {"NIKE"}
    item_status           {1}
    delivery_fee          {1}
    shipping_origin       {1}
    days_until_shipping   {1}
    exhibition_price      {1000}


    # after(:build) do |item|                      
    #   item.images << build(:image, item: item)
    #   item.category_id = create(:grand_child_category).id
    # end                                       
  end
end
