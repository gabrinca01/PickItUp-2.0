class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.integer :user_id
      t.text :description
      t.string :luogo
      t.integer :num_partecipanti
      t.integer :points
      t.timestamps
    end
  end
end
