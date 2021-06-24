class UploadStockJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts 'Well I am here to upload stock'
    
      row = args
      stock_item = StockItem.new
      if StockItem.find_by(name: row[0]).nil?
        stock_item.name = row[0]
      elsif !StockItem.find_by(name: row[0]).nil?
        stock_item = StockItem.find_by name: row[0]
      end
      stock_item.scrape_date = row[2]
      stock_item.price_at_scrape = price_at_scrape_set(row)
      stock_item.price_reduction_rec_retail_at_scrape = price_reduction_rec_retail_at_scrape_set(row)
      stock_item.price_description = row[1]
      stock_item.save
  end
end
