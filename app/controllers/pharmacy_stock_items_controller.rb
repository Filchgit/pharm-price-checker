class PharmacyStockItemsController < ApplicationController
  def index
    @pharmacy_stock_items = policy_scope(PharmacyStockItem)
    @pharmacy_stock_items = PharmacyStockItem.all
    @pharmacy_stock_items = PharmacyStockItem.search_by_name_apn(params[:query]) if params[:query].present?
    respond_to do |format|
      format.html
      format.csv { send_data @pharmacy_stock_items.to_csv }

    
   
    end
  end

  def edit
    if params[:query].present?
      @pharmacy_stock_items = PharmacyStockItem.search_by_name_apn(params[:query])
      #maybe render a partial to appear on the page >?
    end
  
  end  

  def new
    @pharmacy_stock_item = PharmacyStockItem.new
  end

  def upload
    authorize PharmacyStockItem
    PharmacyStockItem.upload(params[:file])
    redirect_to pharmacy_stock_items_index_path
  end

  def update
    @pharmacy_stock_item = PharmacyStockItem.find(params[:id])
    @pharmacy_stock_item.update(pharmacy_stock_item_params)
    @pharmacy_stock_item.save
 
  end

  def pharmacy_stock_item_params
    params.require(:pharmacy_stock_item).permit(:name, :pharmacy_id, :ws1_cost,
                                                :last_invoice_cost, :pde, :apn)
  end

  def compare
    authorize PharmacyStockItem
    authorize StockItem
    @pharmacy_stock_items = PharmacyStockItem.all
    @stock_items = StockItem.all
  end


end
