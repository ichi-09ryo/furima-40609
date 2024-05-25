class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_item_owner, only: [:edit, :update]
  before_action :check_item_sold, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @can_purchase = current_user != @item.user
  end

  def new
    @item = Item.new
  end

  def edit
    @item
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path, notice: 'Item was successfully deleted.'
    else
      redirect_to root_path, alert: 'You are not authorized to delete this item.'
    end
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

  def set_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Item not found.'
  end

  def check_item_owner
    unless current_user.id == @item.user_id
      redirect_to root_path, alert: 'You are not authorized to edit this item.'
    end
  end

  def check_item_sold
    if @item.purchased?
      redirect_to root_path, alert: 'This item has already been sold.'
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :image)
  end
  
end