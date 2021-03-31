class ChangePdeInPharmacyStockItem < ActiveRecord::Migration[6.1]
  def change
    remove_column :pharmacy_stock_items, :apn
    add_column :pharmacy_stock_items, :apn, :bigint
  end
end
