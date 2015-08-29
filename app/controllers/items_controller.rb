class ItemsController < ApplicationController
  before_action :require_login
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    set_users_items
    @item = current_user.items.new
  end

  def create
    @item = current_user.items.new item_params
    if @item.save
      redirect_to :back, flash: { success:  'Item was successfully added' }
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

  def destroy
    @item.destroy
    redirect_to items_path, notice: 'Item was successfully deleted.'
  end

private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def set_users_items
    @items = Item.where(user: current_user)
  end

  def item_params
    params.require(:item).permit(:name, :description, list_assignments_attributes: [:list_id])
  end

end
