class StockApnsController < ApplicationController
  def download
  
    authorize PharmacyStockItem
    authorize StockItem
    authorize Setting
    stock_items = StockItem.all
    @setting = Setting.first
    # ok so I know this is ugly , not dry and shouldn't be here but I am experimenting

    matched_stocks = []
   

    stock_items = stock_items.sort_by &:price_reduction_rec_retail_at_scrape
    stock_items.reverse!
    stock_items.each do |stock_item|
      matched_pharm_stock = PharmacyStockItem.find_by apn: stock_item.apn_barcode_1 
       next if matched_pharm_stock == nil 
       next if stock_item.apn_barcode_1 == 0 || stock_item.apn_barcode_1 == nil 
       if matched_pharm_stock.gst_flag == 'Y' || matched_pharm_stock.gst_flag == nil 
         if matched_pharm_stock.cw_only == 'N' || matched_pharm_stock.cw_only == nil  
           next if stock_item.price_at_scrape * 10/11 > matched_pharm_stock.last_invoice_cost * (@setting.percent_difference + 100)/100 
         else
           next if stock_item.price_at_scrape * 10/11 > matched_pharm_stock.last_invoice_cost * (@setting.cw_price_difference + 100)/100
        end 
        elsif matched_pharm_stock.gst_flag == 'N' || matched_pharm_stock.gst_flag == 'F'
           if matched_pharm_stock.cw_only == 'N' || matched_pharm_stock.cw_only == nil
              next if stock_item.price_at_scrape > matched_pharm_stock.last_invoice_cost * (@setting.percent_difference + 100)/100 
            else  
            next if stock_item.price_at_scrape > matched_pharm_stock.last_invoice_cost * (@setting.cw_price_difference + 100)/100 
            end 
        end
      matched_stocks << matched_pharm_stock
    end
    StockApn.delete_all
    matched_stocks.each do |item|
       StockApn.create( apn: "#{item.apn}" )
    end
    @stock_apns = StockApn.all
    
    puts 'Reached the StockAPNsController'
      send_data @stock_apns.to_csv 
 
  end

end
