class CreateAwards < ActiveRecord::Migration[7.0]
  def change
    create_table :awards do |t|
      t.integer :price
      t.integer :company_id
      t.text :description
      t.integer :left
      t.timestamps
    end
  end
end
