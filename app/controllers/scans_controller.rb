class ScansController < ApplicationController
  before_action :require_login
  
  def new
    @scan = Scan.new
    @lists = current_user.lists
    if params[:quick_entry_mode] == "1"
      @quick_entry_mode = true
    end
  end

  def create
    scan_params = params.require(:scan).permit(:barcode_image, list_ids: [])
    @scan = Scan.new scan_params
    @scan.user = current_user
    if @scan.save
      if params[:scan][:quick_entry_mode] == "1"
        redirect_to new_scan_path(quick_entry_mode: "1", lists: @scan.item.lists.pluck(:id)), flash: { success:  "#{@scan.item.name} was successfully added" }
      else
        redirect_to @scan.item
      end
    else
      if @scan.query_error.present?
        redirect_to new_scan_path(quick_entry_mode: "1", lists: params[:scan][:list_ids]), flash: { error: @scan.query_error }
      else
        @lists = current_user.lists
        render :new
      end
    end
  end
end
