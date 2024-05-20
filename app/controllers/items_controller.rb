class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  #def index
    #@items = Item.all
  #end

  #def show
    #@item = Item.find(params[:id])
  #end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :image)
  end
end