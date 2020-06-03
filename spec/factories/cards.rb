FactoryBot.define do
  factory :card do
    customer_id { "abcdefghijklmnop" }
    card_id     { "abcdefghijklmnop" }
    user
  end
end
