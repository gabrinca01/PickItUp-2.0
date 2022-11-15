class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :gender
      t.string :nome
      t.string :cognome
      t.text :picture
      t.datetime :birthdate
      t.integer :points
      t.timestamps
    end
  end
end
