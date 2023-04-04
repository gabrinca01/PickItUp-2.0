class AddUniqueContraintToRelationship < ActiveRecord::Migration[7.0]
  def change
    def change
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
  end
end
