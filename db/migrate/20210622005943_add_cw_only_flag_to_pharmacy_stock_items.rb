class AddCwOnlyFlagToPharmacyStockItems < ActiveRecord::Migration[6.1]
  def change
    add_column :pharmacy_stock_items, :cw_only, :string
  end
end
