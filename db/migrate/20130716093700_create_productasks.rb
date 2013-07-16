class CreateProductasks < ActiveRecord::Migration
  def change
    create_table :productasks do |t|
      t.integer :product_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
