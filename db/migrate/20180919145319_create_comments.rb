class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :comment_parent, polymorphic: true, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end