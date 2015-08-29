class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    set_users_lists
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.new list_params
    if @list.save
      redirect_to @list, flash: { success:  'List was successfully added' }
    else
      set_users_lists
      render :index
    end
  end

  def show
    @other_items = current_user.items.where.not(id: @list.items.pluck(:id))
    @item = Item.new
    @item.list_assignments.build(list: @list)
    @items = @list.items
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to @list
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: 'List was successfully deleted.'
  end

  private

  def set_list
    @list = current_user.lists.find(params[:id])
  end

  def set_users_lists
    @lists = List.where(user: current_user)
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
