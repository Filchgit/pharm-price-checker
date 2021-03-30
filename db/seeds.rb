# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'byebug'
scraped_items = []
csv_file = File.join(__dir__, 'scraped_prices.csv')
#filename = 'scraped_prices'

CSV.read(csv_file )
CSV.foreach("/home/john/code/Filchgit/pharm-price-checker/db/scraped_prices.csv") do |row|
  puts row
  new_stock_item = StockItem.new
  new_stock_item.name = row[0]
  string_price = row[1]           # not that the prices incoming are in decimal string format 
  new_stock_item.price_at_scrape = string_price.delete('.').to_i
  new_stock_item.price_reduction_rec_retail_at_scrape = row[2].delete('.').to_i
  new_stock_item.scrape_date = row[3]
  new_stock_item.save
end 




 
