class StockItem < ApplicationRecord
  has_one_attached :photo

  # bulk upload stock_items
  # def self.import(file)
  #   CSV.for_each(file.path, headers: false) do |row|
  #     imported_stock_item = StockItem.new
  #     imported_stock_item.name = row[0]
  #     imported_stock_item.price_at_scrape = row[1].to_f
  #     imported_stock_item.price_reduction_rec_retail_at_scrape = row[2].to_f
  #      #imported_stock_item.scrape_date = row[3]
  #   end

  

  def self.upload(file)
    CSV.foreach(file.path) do |row|

      new_stock_item = StockItem.new
      new_stock_item.name = row[0]
      string_price = row[1]           # not that the prices incoming are in decimal string format 
      new_stock_item.price_at_scrape = string_price.delete('.').to_i
      new_stock_item.price_reduction_rec_retail_at_scrape = row[2].delete('.').to_i
      new_stock_item.scrape_date = row[3]
      new_stock_item.save
    end
  end


end
