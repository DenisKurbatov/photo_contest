class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :photo, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
    add_index :likes, [:photo_id, :user_id], unique: true
  end
end
