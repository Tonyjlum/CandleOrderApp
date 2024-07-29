class CreateCandle < ActiveRecord::Migration[7.1]
  def change
    create_table :candles do |t|
      t.integer :fragrance_id, null: false
      t.timestamps
    end

    add_index :candles, :fragrance_id, unique: true
  end
end
