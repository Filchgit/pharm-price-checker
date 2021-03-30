class StockItemsController < ApplicationController
  def index
    @stock_items = StockItem.all
  end

  def new
    @stock_item = StockItem.new
  end

  # def create
  #   StockItem.import(params[:stock_item][:file])
  #   redirect_to stock_items_index_path
  # end

  def upload

    StockItem.upload(params[:file])
    redirect_to stock_items_index_path
  end
  
end
