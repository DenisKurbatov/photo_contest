class AddAllCommentsCounterToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :all_comments_count, :integer, default: 0
  end
end
