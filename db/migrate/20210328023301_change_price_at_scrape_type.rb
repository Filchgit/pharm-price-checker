class ChangePriceAtScrapeType < ActiveRecord::Migration[6.1]
  def change
    remove_column :stock_items, :price_at_scrape
    add_column :stock_items, :price_at_scrape, :decimal, precision: 10, scale: 2
  end
end
