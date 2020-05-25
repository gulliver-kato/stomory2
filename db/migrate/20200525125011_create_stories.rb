class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.string :thumbnail_image, null: false
      t.timestamps
    end
  end
end
