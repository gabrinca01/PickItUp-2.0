class ChangeTableUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
        change_column_default :users, :role,'level0'
    end
  end
end