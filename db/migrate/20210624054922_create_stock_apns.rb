class CreateStockApns < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_apns do |t|
      t.bigint :apn

      t.timestamps
    end
  end
end
