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
  def edit
    @list = current_user.lists.find(params[:id])
  end
  def update
    @list = current_user.lists.find(params[:id])
    if @list.update(params.require(:list).permit(:name))
      redirect_to @list
    else
      render :edit
    end
  end
end
