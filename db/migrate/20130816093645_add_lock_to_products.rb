class AddLockToProducts < ActiveRecord::Migration
  def change
    add_column :products, :lock, :boolean, :default => false
  end
end
