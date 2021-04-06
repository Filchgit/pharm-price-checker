class PharmacyStockItem < ApplicationRecord

  def self.upload(file)
    CSV.foreach(file.path) do |row|
    # need to check if pharmacyStockItem contains a file with stock_item,name == row[15]
      # if not then add it, else just update it 
      # will need to refactor this
      new_stock_item = PharmacyStockItem.new
      new_stock_item.name = row[15]
      new_stock_item.apn = row[16].to_i
      new_stock_item.pde = row[17].to_i
      new_stock_item.ws1_cost = row[18].to_s.delete('.$').to_i
      new_stock_item.last_invoice_cost = row [19].to_s.delete('.$').to_i
      new_stock_item.save
    end
  end
end