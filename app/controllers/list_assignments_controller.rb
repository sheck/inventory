class ListAssignmentsController < ApplicationController
  def new
    @item = current_user.items.find(params[:item_id])
    @lists = current_user.lists
  end
  def create
    # byebug
    @item = current_user.items.find(params[:item_id])
    @list = current_user.lists.find(params[:list_id])
    ListAssignment.create(item: @item, list: @list)
    redirect_to @list
  end
end
