class NewsParameters < ActiveRecord::Migration[7.0]
  def change
    add_column :news,:published,:datetime
    add_column :news,:title,:string
    add_column :news,:url,:stringe

  end
end
