class CreateDeallogs < ActiveRecord::Migration
  def change
    create_table :deallogs do |t|
      t.integer :deal_id
      t.string :description

      t.timestamps
    end
  end
end
