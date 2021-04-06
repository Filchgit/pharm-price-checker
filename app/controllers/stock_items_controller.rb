class StockItemsController < ApplicationController

  def index
    @stock_items = StockItem.all
  end

  def new
    @stock_item = StockItem.new
  end

  def edit
    @stock_item = StockItem.find(params[:id])
    @pharmacy_stock_items = PharmacyStockItem.all
  end

  def update
    @stock_item = StockItem.find(params[:id])
    @stock_item.update(stock_item_params)
    @stock_item.save
    redirect_to stock_items_index_path
  end

  def upload
    StockItem.upload(params[:file])
    redirect_to stock_items_index_path
  end

  def stock_item_params
    params.require(:stock_item).permit(:name, :scrape_date, :price_reduction_rec_retail_at_scrape,
                                       :price_at_scrape, :price_description, :pde, :apn_barcode_1 )
  end
end
