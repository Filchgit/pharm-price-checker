class PharmacyStockItemsController < ApplicationController
  def index
    @pharmacy_stock_items = PharmacyStockItem.all
  end

  def new
    @pharmacy_stock_item = PharmacyStockItem.new
  end

  def upload
    PharmacyStockItem.upload(params[:file])
    redirect_to pharmacy_stock_items_index_path
  end

end
