class AddCommentsCountToPhotosAndComments < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :comments_count, :integer, default: 0
    add_column :comments, :comments_count, :integer, default: 0
  end
end
