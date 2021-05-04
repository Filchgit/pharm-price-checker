class StockItem < ApplicationRecord
  has_one_attached :photo
  validates :name, uniqueness: true

  def self.upload(file) 
    # upload is for uploading the scraped files via SQL / C#
    return if file.nil?

    CSV.foreach(file.path) do |row|
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

  def self.csv_upload(file)
    # csv_upload is for uploading off backupped files
    return if file.nil?

    CSV.foreach(file.path) do |row|
      stock_item = StockItem.new
      if StockItem.find_by(name: row[1]).nil?
        stock_item.name = row[1]
      elsif !StockItem.find_by(name: row[1]).nil?
        stock_item = StockItem.find_by name: row[1]
      end
      stock_item.scrape_date = row[2]
      stock_item.price_at_scrape = row[6]
      stock_item.price_reduction_rec_retail_at_scrape = row[3]
      stock_item.price_description = row[7]
      stock_item.pde = row[8]
      stock_item.apn_barcode_1 = row[9]
      stock_item.save
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |stock_item|
        csv << stock_item.attributes.values
      end
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by_name_apn, against: [:name, :apn_barcode_1], using: { tsearch: { prefix: true } }

  def self.price_at_scrape_set(row)
    dec_index = row[3].index('.')
    case dec_index
    when nil
      price_at_scrape = "#{row[3]}00"
    when 1
      price_at_scrape = "#{row[3].to_s.delete('.')}0" if row[3].to_s.length == 3
      price_at_scrape = row[3].to_s.delete('.').to_i  if row[3].to_s.length != 3
    else
      price_at_scrape = row[3].to_s.delete('.').to_i
    end
    price_at_scrape
  end

  def self.price_reduction_rec_retail_at_scrape_set(row)
    dec_rec_index = row[4].index('.')
    case dec_rec_index
    when nil
      price_reduction_rec_retail_at_scrape = "#{row[4]}00"
    when 1
      price_reduction_rec_retail_at_scrape = "#{row[4].to_s.delete('.')}0" if row[4].to_s.length == 3
      price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.') if row[4].to_s.length != 3
    else
      price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.').to_i
    end
    price_reduction_rec_retail_at_scrape
  end
end
