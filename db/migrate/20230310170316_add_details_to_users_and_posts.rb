class AddDetailsToUsersAndPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :num_tel, :string
    add_column :users, :num_tel, :text
    add_column :users,:country_code,:string
    add_column :posts,:verified,:boolean
  end
end
