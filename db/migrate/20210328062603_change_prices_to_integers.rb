class ChangePricesToIntegers < ActiveRecord::Migration[6.1]
  def change
    remove_column :stock_items, :price_at_scrape
    add_column :stock_items, :price_at_scrape, :integer
    remove_column :stock_items, :price_description
    add_column :stock_items, :price_description, :string
  end
end
