class StockItem < ApplicationRecord
  has_one_attached :photo

  validates :name, uniqueness: true

  def self.upload(file)
    CSV.foreach(file.path) do |row|
      # need to check if StockItem contains a file with stock_item,name == row[0]
      # if not then add it, else just update it 
      # will need to refactor this
      item_exists = false
      stock_array = StockItem.all
      stock_array.each do |item|
        item_exists = true if item.name == row[0]
      end

      if item_exists == false
        new_stock_item = StockItem.new
        new_stock_item.name = row[0]
        new_stock_item.scrape_date = row[2]
        new_stock_item.price_at_scrape = row[3].to_s.delete('.').to_i
        new_stock_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.').to_i
        new_stock_item.save
      else
        # need to update item.
        update_item = StockItem.find_by name: row[0]
        update_item.scrape_date = row[2]
        update_item.price_at_scrape = row[3].to_s.delete('.').to_i
        update_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.').to_i
        update_item.save
      end
    end
  end
end
