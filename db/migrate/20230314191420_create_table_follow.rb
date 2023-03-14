class CreateTableFollow < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :follower
      t.integer :followee
      t.timestamps
    end
  end
end
