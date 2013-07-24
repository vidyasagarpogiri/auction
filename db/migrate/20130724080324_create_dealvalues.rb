class CreateDealvalues < ActiveRecord::Migration
  def change
    create_table :dealvalues do |t|
      t.integer :deal_id
      t.integer :user_id
      t.string :value
      t.text :comment

      t.timestamps
    end
  end
end
