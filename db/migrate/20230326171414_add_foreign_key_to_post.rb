class AddForeignKeyToPost < ActiveRecord::Migration[7.0]
  def change

     add_column :posts, :challenge_id,:integer
      
  end
end
