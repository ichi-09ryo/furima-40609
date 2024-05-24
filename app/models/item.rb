class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order, class_name: 'Order', foreign_key: 'item_id'
  has_one_attached :image

  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_date

  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 1, message: 'must be other than 1' } do
    validates :category_id
    validates :prefecture_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :shipping_date_id
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end