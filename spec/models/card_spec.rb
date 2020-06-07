require 'rails_helper'
describe Card do
  describe '#create' do
    it "user_id、customer_id、card_idが存在すれば登録できること" do
      card = build(:card)
      expect(card).to be_valid
    end
    it "customer_idがない場合は登録できないこと" do
      card = build(:card, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
    it "customer_idが存在すれば登録できること" do
      card = build(:card, customer_id: "qrltuvwxyz")
      expect(card).to be_valid
    end
    it "card_idがない場合は登録できないこと" do
      card = build(:card, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
    it "card_idが存在すれば登録できること" do
      card = build(:card, card_id: "qrltuvwxyz")
      expect(card).to be_valid
    end
  end
end