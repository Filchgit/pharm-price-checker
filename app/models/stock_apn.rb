class StockApn < ApplicationRecord
  def download

  end

  def self.to_csv
    CSV.generate do |csv|
      all.each do |stock_apns|
        csv << stock_apns.attributes.values
      end
    end
  end
end
