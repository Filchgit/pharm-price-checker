class StockItem < ApplicationRecord
  has_one_attached :photo

  def self.upload(file)
    CSV.foreach(file.path) do |row|

      new_stock_item = StockItem.new
      new_stock_item.name = row[0]      
      new_stock_item.scrape_date = row[2]
      new_stock_item.price_at_scrape = row[3].to_s.delete('.').to_i
 
      new_stock_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.').to_i
      new_stock_item.save
    end
  end


end
