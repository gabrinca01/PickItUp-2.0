class AddDetailsToChallenge < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges,:temp_date,:date
    add_column :challenges,:temp_time,:time
    add_column :challenges,:raggio,:string
    add_column :challenges,:def_date,:date
    add_column :challenges,:def_time,:time
   
  end
end
