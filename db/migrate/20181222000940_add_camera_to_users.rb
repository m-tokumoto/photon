class AddCameraToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :camera, :string
  end
end
