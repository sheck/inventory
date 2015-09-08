class ItemsController < ApplicationController
  before_action :require_login
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    set_users_items
    @item = current_user.items.new
  end

  def new
    @item = Item.new
    if params[:list_id]
      @item.list_assignments.build(list: @list)
    end
  end

  def create
    @item = current_user.items.new item_params
    verify_list_belongs_to_user or return
    if @item.save
      redirect_to return_to_path, flash: { success:  'Item was successfully added' }
    else
      set_users_items
      render :new
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
    params.require(:item).permit(:name, :description, :photo, list_assignments_attributes: [:list_id])
  end

  def return_to_path
    path = params.require(:item).permit(:return_to)[:return_to] 
    path ? path : items_path
  end

  def verify_list_belongs_to_user
    if @item.list_assignments.any? && @item.user != @item.list_assignments.first.user
      redirect_to root_path and return
    else
      return true
    end
  end

end
