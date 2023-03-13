class ChangeDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :num_tel, :text
    add_column :users, :num_tel, :string
  end
end
