class ListAssignmentsController < ApplicationController
  before_action :require_login

  def new
    @item = current_user.items.find(params[:item_id])
    @lists = current_user.lists.where.not(id: @item.lists.pluck(:id))
    @current_lists = @item.lists
  end

  def create
    @item = current_user.items.find(params[:item_id])
    @list = current_user.lists.find(params[:list_id])
    @list.add_item @item
    redirect_to @list
  end

  def destroy
    list_assignment = current_user.list_assignments.find(params[:id])
    @list = list_assignment.list
    list_assignment.destroy
    redirect_to @list
  end
end
