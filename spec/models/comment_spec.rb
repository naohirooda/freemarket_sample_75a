require 'rails_helper'
describe Comment do
  describe '#create' do
    it "user_id、item_id、commentが存在すれば登録できること" do
      comment = build(:comment)
      expect(comment).to be_valid
    end
    it "commentがない場合は登録できないこと" do
      comment = build(:comment, comment: "")
      comment.valid?
      expect(comment.errors[:comment]).to include("を入力してください")
    end
  end
end