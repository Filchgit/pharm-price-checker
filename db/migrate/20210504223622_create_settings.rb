class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.string :name_pharmacy
      t.integer :percent_difference

      t.timestamps
    end
  end
end
