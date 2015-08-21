class ItemsController < ApplicationController
  before_action :require_login

  def index
    @items = current_user.items
  end

  def create
    current_user.items.create params.require(:item).permit(:name, :description)
    redirect_to items_path
  end
end
