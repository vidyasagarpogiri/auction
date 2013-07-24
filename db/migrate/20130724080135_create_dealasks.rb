class CreateDealasks < ActiveRecord::Migration
  def change
    create_table :dealasks do |t|
      t.integer :deal_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
