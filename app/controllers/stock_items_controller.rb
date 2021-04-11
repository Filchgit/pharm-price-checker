class StockItemsController < ApplicationController

  def index
    @stock_items = policy_scope(StockItem)
    @stock_items = StockItem.all.sort_by &:price_reduction_rec_retail_at_scrape
    @stock_items.reverse!      # as I want the results with highests savings on top
    if params[:query].present?
      @stock_items = StockItem.search_by_name_apn(params[:query])
    end 
    
  end

  def new
    @stock_item = StockItem.new
  end

  def edit
    @stock_item = StockItem.find(params[:id])
    @pharmacy_stock_items = PharmacyStockItem.all
    if params[:query].present?
      @pharmacy_stock_items = PharmacyStockItem.search_by_name_apn(params[:query])
    end 
    authorize @stock_item 
  end

  def update
     
    @stock_item = StockItem.find(params[:id])
    @stock_item.update(stock_item_params)
    authorize @stock_item
    @stock_item.save
    redirect_to stock_items_index_path
  end

  def upload
    authorize StockItem
    StockItem.upload(params[:file])
    redirect_to stock_items_index_path
  end

  def stock_item_params
    params.require(:stock_item).permit(:name, :scrape_date, :price_reduction_rec_retail_at_scrape,
                                       :price_at_scrape, :price_description, :pde, :apn_barcode_1 )
  end
end
