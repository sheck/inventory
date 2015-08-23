class ItemsController < ApplicationController
  before_action :require_login
  before_action :find_users_items, only: :index

  def index
    @item = current_user.items.new
  end

  def create
    @item = current_user.items.new item_params
    if @item.save
      redirect_to items_path, flash: { success:  'Item was successfully added' }
    else
      find_users_items
      render :index
    end
  end

private

  def find_users_items
    @items = current_user.items
  end
  
  def item_params
    params.require(:item).permit(:name, :description)
  end

end
