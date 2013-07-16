class CreateProductaskres < ActiveRecord::Migration
  def change
    create_table :productaskres do |t|
      t.integer :productask_id
      t.text :content

      t.timestamps
    end
  end
end
