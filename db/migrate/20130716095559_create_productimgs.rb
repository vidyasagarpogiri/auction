class CreateProductimgs < ActiveRecord::Migration
  def change
    create_table :productimgs do |t|
      t.integer :product_id
      t.string :path

      t.timestamps
    end
  end
end
