class ChangeApnInStockItem < ActiveRecord::Migration[6.1]
  def change
    remove_column :stock_items, :apn_barcode_1
    add_column :stock_items, :apn_barcode_1, :bigint
  end
end
