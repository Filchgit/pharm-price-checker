class CreatePharmacyStockItems < ActiveRecord::Migration[6.1]
  def change
    create_table :pharmacy_stock_items do |t|
      t.string :name
      t.integer :pharmacy_id
      t.integer :apn
      t.integer :ws1_cost
      t.integer :last_invoice_cost

      t.timestamps
    end
  end
end
