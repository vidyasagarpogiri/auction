class ChangeProductclassProductclassColumnName < ActiveRecord::Migration
  def up
  	rename_column :productclasses, :parent_class, :parent_id
  end

  def down
  end
end
