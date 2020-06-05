FactoryBot.define do
  factory :comment do
    comment {"abcdefghijklmnop"}
    user
    item
  end
end
