require 'rails_helper'
describe User do
  describe '#create' do
    it "nickname、email、password、password_confirmation、first_name、last_name、first_name_kana、last_name_kanaが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "重複したnicknameが存在する場合は登録できないこと " do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("はすでに存在します")
    end
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "重複したemailが存在する場合は登録できないこと " do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "passwordとpassword_confirmationが一致しない場合は登録できないこと" do
      user = build(:user, password_confirmation: "1234567")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "passwordが7文字未満であれば登録できないこと" do
      user = build(:user, password: "123456")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end
    it "passwordが7文字以上であれば登録できること" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user).to be_valid
    end
    it "first_nameがない場合は登録できないこと" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end
    it "last_nameがない場合は登録できないこと" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end
    it "first_name_kanaがない場合は登録できないこと" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end
    it "first_name_kanaが全角カタカナでない場合は登録できないこと" do
      user = build(:user, first_name_kana: "太郎")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end
    it "first_name_kanaが全角カタカナである場合は登録できること" do
      user = build(:user, first_name_kana: "ジロウ")
      user.valid?
      expect(user).to be_valid
    end
    it "last_name_kanaがない場合は登録できないこと" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end
    it "last_name_kanaが全角カタカナでない場合は登録できないこと" do
      user = build(:user, last_name_kana: "山田")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("は全角カタカナで入力して下さい")
    end
    it "last_name_kanaが全角カタカナである場合は登録できること" do
      user = build(:user, last_name_kana: "スズキ")
      user.valid?
      expect(user).to be_valid
    end
  end
end