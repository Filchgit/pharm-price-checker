class PharmacyStockItem < ApplicationRecord

  def self.upload(file)
    if file != nil
      CSV.foreach(file.path) do |row|
        item_exists = false
        pharmacy_stock_array = PharmacyStockItem.all
        pharmacy_stock_array.each do |item|
          item_exists = true if item.name == row[15]
        end
        # will need to refactor this
        if item_exists == false  
          new_pharmacy_item = PharmacyStockItem.new
          new_pharmacy_item.name = row[15]
          new_pharmacy_item.apn = row[16].to_i
          new_pharmacy_item.pde = row[17].to_i
          new_pharmacy_item.ws1_cost = row[18].to_s.delete('.$').to_i
          new_pharmacy_item.last_invoice_cost = row [19].to_s.delete('.$').to_i
          new_pharmacy_item.save
        elsif item_exists == true
          # need to update item.
          update_pharmacy_item = PharmacyStockItem.find_by name: row[15]
          update_pharmacy_item.apn = row[16].to_i
          update_pharmacy_item.pde = row[17].to_i
          update_pharmacy_item.ws1_cost = row[18].to_s.delete('.$').to_i
          update_pharmacy_item.last_invoice_cost = row [19].to_s.delete('.$').to_i
          update_pharmacy_item.save 
        end
      end
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |pharmacy_stock_item|
        csv << pharmacy_stock_item.attributes.values
      end
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by_name_apn, against: [:name, :apn], using: { tsearch: { prefix: true } }
end