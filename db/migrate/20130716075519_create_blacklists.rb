class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.integer :user_id
      t.integer :block_id
      t.string :block_name

      t.timestamps
    end
  end
end
