class AddAttrsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tel, :string
    add_column :users, :name, :string
    add_column :users, :aboutme, :text
    add_column :users, :accountinfo, :text
    add_column :users, :status, :string
  end
end
