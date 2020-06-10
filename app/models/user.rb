class User < ApplicationRecord
  has_one :address,    dependent: :destroy
  has_one :card,       dependent: :destroy
  has_many :items,     dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :items,     through: :favorites

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname,                         presence: true, uniqueness: true
  validates :password,                         length: { in: 7..128 }
  validates :first_name, :last_name,           presence: true
  validates :first_name_kana, :last_name_kana, presence: true,
                                               format: {
                                               with: /\A[ァ-ヶー－]+\z/,
                                               message: "は全角カタカナで入力して下さい"
                                               }
  validates :email,                             presence: true, length: { maximum: 255 },
                                                format: {
                                                with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
end