class ItemsController < ApplicationController
  before_action :require_login
  before_action :set_users_items, only: :index
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @item = current_user.items.new
  end

  def create
    @item = current_user.items.new item_params
    if @item.save
      redirect_to items_path, flash: { success:  'Item was successfully added' }
    else
      set_users_items
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

private

  def set_item
    @item = Item.where(user: current_user).find(params[:id])
  end

  def set_users_items
    @items = Item.where(user: current_user) 
  end

  def item_params
    params.require(:item).permit(:name, :description)
  end

end
