class AddGstFlagToPharmacyStockItems < ActiveRecord::Migration[6.1]
  def change
    add_column :pharmacy_stock_items, :gst_flag, :string
  end
end
