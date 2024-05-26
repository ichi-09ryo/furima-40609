class ItemOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id,
                :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :token, :city, :block, :user_id, :item_id
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    order = Order.create(user_id:, item_id:)
    Payment.create(
      postcode:,
      prefecture_id:,
      city:,
      block:,
      building:,
      phone_number:,
      order_id: order.id
    )
  end
end
