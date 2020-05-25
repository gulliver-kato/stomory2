class AddStoryRefToParts < ActiveRecord::Migration[5.2]
  def change
    add_reference :parts, :story, foreign_key: true
  end
end
