class ListsController < ApplicationController
  def index
    @lists = current_user.lists
  end
  def create
    @list = current_user.lists.create params.require(:list).permit(:name)
    redirect_to @list
  end
  def show
    @list = current_user.lists.find(params[:id])
  end
end
