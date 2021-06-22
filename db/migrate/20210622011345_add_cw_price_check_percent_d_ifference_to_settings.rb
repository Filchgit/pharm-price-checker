class AddCwPriceCheckPercentDIfferenceToSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :settings, :cw_price_difference, :integer
  end
end
