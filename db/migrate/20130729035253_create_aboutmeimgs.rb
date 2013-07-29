class CreateAboutmeimgs < ActiveRecord::Migration
  def change
    create_table :aboutmeimgs do |t|
      t.integer :user_id
      t.string :image
      t.string :name

      t.timestamps
    end
  end
end
