class AddPdeToPharmacyStockItem < ActiveRecord::Migration[6.1]
  def change
    add_column :pharmacy_stock_items, :pde, :integer
  end
end
