class CreateProductimgs < ActiveRecord::Migration
  def change
    create_table :productimgs do |t|
      t.integer :product_id
      t.string :image
      t.string :name

      t.timestamps
    end
  end
end
