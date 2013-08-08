class AddNestedAttrsToProductclasses < ActiveRecord::Migration
  def change
    add_column :productclasses, :lft, :integer
    add_column :productclasses, :rgt, :integer
    add_column :productclasses, :depth, :integer
  end
end
