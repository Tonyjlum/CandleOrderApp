class CreateFragrance < ActiveRecord::Migration[7.1]
  def change
    create_table :fragrances do |t|
      t.string      :name,          null: false
      t.string      :description,   null: false
      t.string      :category,      null: false
      t.string      :image_url,     null: false
      t.timestamps
    end
  end


end
