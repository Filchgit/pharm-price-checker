class AddPdeToStockItem < ActiveRecord::Migration[6.1]
  def change
    add_column :stock_items, :pde, :integer
  end
end
