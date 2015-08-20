class ItemsController < ApplicationController
  before_action :require_login

  def index
    @items = Item.all
  end

  def create
    Item.create params.require(:item).permit(:name, :description)
    redirect_to items_path
  end
end
