class PharmacyStockItem < ApplicationRecord
  def self.upload(file)
    return if file.nil?

    CSV.foreach(file.path) do |row|
      if PharmacyStockItem.find_by(name: row[15]).nil?
        pharmacy_item = PharmacyStockItem.new
        pharmacy_item.name = row[15]
      elsif !PharmacyStockItem.find_by(name: row[15]).nil?
        pharmacy_item = PharmacyStockItem.find_by name: row[15]

        pharmacy_item.apn = row[16].to_i
        pharmacy_item.pde = row[17].to_i
        pharmacy_item.ws1_cost = row[18].to_s.delete('.$').to_i
        pharmacy_item.last_invoice_cost = row [19].to_s.delete('.$').to_i

        pharmacy_item.save

        # update_pharmacy_item.apn = row[16].to_i
        # update_pharmacy_item.pde = row[17].to_i
        # update_pharmacy_item.ws1_cost = row[18].to_s.delete('.$').to_i
        # update_pharmacy_item.last_invoice_cost = row [19].to_s.delete('.$').to_i
        # update_pharmacy_item.save
      end
    end
  end

  def self.gst_upload(file)
    return if file.nil?

    CSV.foreach(file.path) do |row|
      unless PharmacyStockItem.find_by(name: row[18]).nil?
        pharmacy_item = PharmacyStockItem.find_by name: row[18]  
        pharmacy_item.gst_flag = row[31]
        pharmacy_item.save
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
