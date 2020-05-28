class User < ApplicationRecord
  has_one :address
  has_many :items
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,                             presence: true, length: { maximum: 255 },
                                                format: {
                                                with: VALID_EMAIL_REGEX}
end