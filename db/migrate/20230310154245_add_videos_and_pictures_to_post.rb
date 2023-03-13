class AddVideosAndPicturesToPost < ActiveRecord::Migration[7.0]
  def change
    
    remove_column :posts,:media_location,:string
  end
end
