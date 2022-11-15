class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :nome
      t.string :logo
      t.string :sito
      t.timestamps
    end
  end
end
