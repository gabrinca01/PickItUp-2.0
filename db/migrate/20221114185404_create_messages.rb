class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text  :msg_txt
      t.integer :user_id
      t.integer :challenge_id
      t.timestamps
    end
  end
end
