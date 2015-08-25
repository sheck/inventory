class ListAssignmentsController < ApplicationController
  def new
    @item = current_user.items.find(params[:item_id])
    @lists = current_user.lists.where.not(id: @item.lists.pluck(:id))
  end
  def create
    @item = current_user.items.find(params[:item_id])
    @list = current_user.lists.find(params[:list_id])
    ListAssignment.create(item: @item, list: @list)
    redirect_to @list
  end
  def destroy
    list_assignment = ListAssignment.find(params[:id])
    @list = list_assignment.list
    list_assignment.destroy
    redirect_to @list
  end
end
