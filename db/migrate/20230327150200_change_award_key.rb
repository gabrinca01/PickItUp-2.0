class ChangeAwardKey < ActiveRecord::Migration[7.0]
  def change
    remove_column :awards,:company_id,:integer
    add_column :awards,:user_id,:integer
  end
end
