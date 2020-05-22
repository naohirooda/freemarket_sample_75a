require 'rails_helper'
describe Address do
  describe '#create_address' do
    it "post_code、preficture、city、address、building_name、phone_numberが存在すれば登録できること" do
      address = build(:address)
      expect(address).to be_valid
    end
    it "post_codeがない場合は登録できないこと" do
      address = build(:address, post_code: "")
      address.valid?
      expect(address.errors[:post_code]).to include("を入力してください")
    end
    it "post_codeが7桁未満の場合は登録できないこと" do
      address = build(:address, post_code: "123456")
      address.valid?
      expect(address.errors[:post_code]).to include("はハイフンなしで、半角数字で7桁入力して下さい")
    end
    it "post_codeが8桁以上の場合は登録できないこと" do
      address = build(:address, post_code: "12345678")
      address.valid?
      expect(address.errors[:post_code]).to include("はハイフンなしで、半角数字で7桁入力して下さい")
    end
    it "post_codeが7桁の場合は登録できること" do
      address = build(:address, post_code: "8000022")
      expect(address).to be_valid
    end
    it "post_codeが半角数字でない場合は登録できないこと" do
      address = build(:address, post_code: "１２３４５６７")
      address.valid?
      expect(address.errors[:post_code]).to include("はハイフンなしで、半角数字で7桁入力して下さい")
    end
    it "post_codeが半角数字である場合は登録できること" do
      address = build(:address, post_code: "8000022")
      expect(address).to be_valid
    end
    it "prefictureがない場合は登録できないこと" do
      address = build(:address, preficture: "")
      address.valid?
      expect(address.errors[:preficture]).to include("を入力してください")
    end
    it "存在しないprefictureの場合は登録できないこと" do
      address = build(:address, preficture: "test県")
      address.valid?
      expect(address.errors[:preficture]).to include("は存在しません")
    end
    it "都・道・府・県が含まれていないprefictureは登録できない" do
      address = build(:address, preficture: "福岡")
      address.valid?
      expect(address.errors[:preficture]).to include("は存在しません")
    end
    it "都・道・府・県が含まれているprefictureは登録できること" do
      address = build(:address, preficture: "東京都")
      expect(address).to be_valid
    end
    it "cityがない場合は登録できないこと" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end
    it "addressがない場合は登録できないこと" do
      address = build(:address, address: "")
      address.valid?
      expect(address.errors[:address]).to include("を入力してください")
    end
    it "building_nameがなくても登録できること" do
      address = build(:address, building_name: "")
      expect(address).to be_valid
    end
    it "phone_numberがなくても登録できること" do
      address = build(:address, phone_number: "")
      expect(address).to be_valid
    end
  end
end