class CreateProductregions < ActiveRecord::Migration
  def change
    create_table :productregions do |t|
      t.string :region

      t.timestamps
    end
  end
end
