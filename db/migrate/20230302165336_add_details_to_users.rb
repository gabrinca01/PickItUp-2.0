class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :num_tel, :string
    add_column :users, :accumulated_points, :decimal
    add_column :users, :points, :decimal
    add_column :users, :username, :string
  end
end
