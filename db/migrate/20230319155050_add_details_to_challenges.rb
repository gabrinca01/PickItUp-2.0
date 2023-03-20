class AddDetailsToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges,:durata, :integer
  end
end
