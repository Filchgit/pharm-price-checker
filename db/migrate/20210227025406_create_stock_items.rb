class CreateStockItems < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_items do |t|
      t.string :name
      t.integer :price_description
      t.date :scrape_date
      t.integer :price_at_scrape
      t.integer :price_reduction_rec_retail_at_scrape

      t.timestamps
    end
  end
end
