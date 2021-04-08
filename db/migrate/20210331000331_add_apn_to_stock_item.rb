class AddApnToStockItem < ActiveRecord::Migration[6.1]
  def change
    add_column :stock_items, :apn_barcode_1, :integer
  end
end
