class AddIsreadToModels < ActiveRecord::Migration
  def change
  	add_column :deals, :isread, :string, :default => "false"
  	add_column :dealasks, :isread, :string, :default => "false"
  	add_column :dealvalues, :isread, :string, :default => "false"
  	add_column :deallogs, :isread, :string, :default => "false"
  	add_column :productasks, :isread, :string, :default => "false"
  	add_column :productaskres, :isread, :string, :default => "false"
  end
end
