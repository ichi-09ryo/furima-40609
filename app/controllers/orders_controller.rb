class OrdersController < ApplicationController
  def index
    @oreder = Order.find(params[:order_id])
    @orders = @item.orders
  end

  def create
    @item = Item.find(params[:item_id])
    @order = @item.orders.build(order_params)
    if @order.save
      redirect_to item_orders_path(@item)
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :item_id)
  end
end
