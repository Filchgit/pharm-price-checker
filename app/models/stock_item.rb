class StockItem < ApplicationRecord
  has_one_attached :photo

  validates :name, uniqueness: true

  def self.upload(file)
    return if file.nil?

    CSV.foreach(file.path) do |row|
      # well I really need to refactor this
      item_exists = false
      stock_array = StockItem.all
      stock_array.each do |item|
        item_exists = true if item.name == row[0]
      end
      if item_exists == false # need to do something about the headers, if I leave them in 
        # gosh this is a lot of hassle to avoid using decimals for money!!!
        new_stock_item = StockItem.new
        new_stock_item.name = row[0]
        new_stock_item.scrape_date = row[2]

        dec_index = row[3].index('.')
        case dec_index
        when nil
          new_stock_item.price_at_scrape = "#{row[3]}00"
        when 1
          if row[3].to_s.length == 3
            new_stock_item.price_at_scrape = "#{row[3].to_s.delete('.')}0"
          else
            new_stock_item.price_at_scrape = row[3].to_s.delete('.').to_i
          end
        else
          new_stock_item.price_at_scrape = row[3].to_s.delete('.').to_i 
        end

        dec_rec_index = row[4].index('.')
        case dec_rec_index
        when nil
          new_stock_item.price_reduction_rec_retail_at_scrape = "#{row[4]}00"
        when 1
          if row[4].to_s.length == 3
            new_stock_item.price_reduction_rec_retail_at_scrape = "#{row[4].to_s.delete('.')}0"
          else
            new_stock_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.')
          end
        else
          new_stock_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.').to_i
        end

        new_stock_item.price_description = row[1]
        new_stock_item.save

      elsif item_exists == true
        # need to update item.
        update_item = StockItem.find_by name: row[0]
        update_item.scrape_date = row[2]

        update_item.price_at_scrape = row[3].to_s.delete('.').to_i
        update_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.').to_i
        dec_index = row[3].index('.')
        case dec_index
        when nil
          update_item.price_at_scrape = "#{row[3]}00"
        when 1
          if row[3].to_s.length == 3
            update_item.price_at_scrape = "#{row[3].to_s.delete('.')}0"
          else
            update_item.price_at_scrape = row[3].to_s.delete('.').to_i
          end
        else
          update_item.price_at_scrape = row[3].to_s.delete('.').to_i
        end

        dec_rec_index = row[4].index('.')
        case dec_rec_index
        when nil
          update_item.price_reduction_rec_retail_at_scrape = "#{row[4]}00"
        when 1
          if row[4].to_s.length == 3
            update_item.price_reduction_rec_retail_at_scrape = "#{row[4].to_s.delete('.')}0"
          else
            update_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.')
          end
        else
          update_item.price_reduction_rec_retail_at_scrape = row[4].to_s.delete('.').to_i
        end

        update_item.price_description = row[1]
        update_item.save
      end
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      # not coming here at all for some reason
      csv << column_names
      all.each do |stock_item|
        csv << stock_item.attributes.values
      end
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by_name_apn, against: [:name, :apn_barcode_1], using: { tsearch: { prefix: true } }


end
