class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, uniqueness: true
  validates :email, uniqueness: true
  validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龯ー－]+\z/ }
  validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龯ー－]+\z/ }
  validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/ }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/ }
  validates :birthday, uniqueness: true
  end
