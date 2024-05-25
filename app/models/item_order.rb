class ItemOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id,
                :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :token, :city, :block
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(
      postcode: postcode,
      prefecture_id: prefecture_id,
      city: city,
      block: block,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end