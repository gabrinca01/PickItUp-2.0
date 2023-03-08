class ChangeColumnNameToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :profile_picture, :string
    add_column :users, :image, :text
  end
end
