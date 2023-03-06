class CreateJoinChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :join_challenges do |t|
      t.integer :challenge_id
      t.integer :user_id

      t.timestamps
    end
  end
end
