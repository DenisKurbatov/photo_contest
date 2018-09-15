class Comment < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :photo, class_name: "Photo", foreign_key: "photo_id"

  has_many :comment_children, class_name: "Comment", foreign_key: "comment_parent_id"
  belongs_to :comment_parent, class_name: "Comment", foreign_key: "comment_parent_id", optional: true
  scope :comments_for, ->(photo, parent_id) {where(photo_id: photo, comment_parent_id: parent_id)}


end
