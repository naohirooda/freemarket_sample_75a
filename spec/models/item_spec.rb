require 'rails_helper'
describe Item do
  describe '#create' do
  # RSpec.describe Item, type: :model do
      
    it "全ての必須項目が入力されている場合出品できる" do
      item = FactoryBot.build(:item)
      expect(item).to be_valid
    end

    it "imageがない場合は登録できないこと" do
      item = build(:item )
      item.images = []
      item.valid?
      expect(item.errors[:images]).to include("を入力してください")
    end

    it "nameがない場合は登録できないこと" do
      item = build(:item,  name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "category_idがない場合は登録できないこと" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "brand_nameがなくてもは登録できること" do
      item = build(:item, brand_name: "")
      item.valid?
      expect(true).to_not be_nil
    end

    it "item_statusがない場合は登録できないこと" do
      item = build(:item, item_status: "")
      item.valid?
      expect(item.errors[:item_status]).to include("を入力してください")
    end

    it "delivery_feeがない場合は登録できないこと" do
      item = build(:item, delivery_fee: "")
      item.valid?
      expect(item.errors[:delivery_fee]).to include("を入力してください")
    end

    it "shipping_originがない場合は登録できないこと" do
      item = build(:item, shipping_origin: "")
      item.valid?
      expect(item.errors[:shipping_origin]).to include("を入力してください")
    end

    it "days_until_shippingがない場合は登録できないこと" do
      item = build(:item, days_until_shipping: "")
      item.valid?
      expect(item.errors[:days_until_shipping]).to include("を入力してください")
    end

    it "exhibition_priceがない場合は登録できないこと" do
      item = build(:item, exhibition_price: "")
      item.valid?
      expect(item.errors[:exhibition_price]).to include("を入力してください")
    end
  end
end
