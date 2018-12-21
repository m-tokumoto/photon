class AddImageIdToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :image_id, :string
  end
end
