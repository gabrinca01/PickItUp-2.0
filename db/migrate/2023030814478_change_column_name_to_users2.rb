class ChangeColumnNameToUsers2 < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :image, :text
    add_column :users, :image_data, :text
  end
end