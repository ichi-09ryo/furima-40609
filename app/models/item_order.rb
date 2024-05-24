class ItemOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :number, :exp_month, :exp_year, :cvc,
                :postal_code, :prefecture_id, :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :token, :city, :block
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order.id)
    ShippingAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      block: block,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end