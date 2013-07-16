class CreateStatusLogs < ActiveRecord::Migration
  def change
    create_table :status_logs do |t|
      t.integer :user_id
      t.string :status
      t.text :reason

      t.timestamps
    end
  end
end
