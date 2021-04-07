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

  def update
    @pharmacy_stock_item = PharmacyStockItem.find(params[:id])
    @pharmacy_stock_item.update(pharmacy_stock_item_params)
    @pharmacy_stock_item.save
    redirect_to _pharmacy_stock_items_index_path
  end

  def pharmacy_stock_item_params
    params.require(:pharmacy_stock_item).permit(:name, :pharmacy_id, :ws1_cost,
                                                :last_invoice_cost, :pde, :apn)
  end

end
