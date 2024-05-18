class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  has_one_attached :image

  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_date

  with_options presence: true do
    validates :user_id
    validates :name
    validates :description
    validates :price
    validates :category_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_date_id
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :delivery_area_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :shipping_date_id
  end
end