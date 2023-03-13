class AddPhoneNumberIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :num_tel, unique: true
  end
end
