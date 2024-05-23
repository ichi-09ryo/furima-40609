# app/models/item_order.rb
class ItemOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :amount, :token, :postal_code, :prefecture, :city, :address, :building, :phone_number

  validates :user_id, :item_id, :amount, :token, :postal_code, :prefecture, :city, :address, :phone_number, presence: true

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(amount: amount, order_id: order.id)
    ShippingAddress.create(postal_code: postal_code, prefecture: prefecture, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end