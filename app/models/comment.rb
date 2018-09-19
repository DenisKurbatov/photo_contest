class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :comment_parent, polymorphic: true
  has_many :comments, as: :comment_parent
  scope :get_comments, ->(type, id) { where(comment_parent_type: type, comment_parent_id: id )}
  # Ex:- scope :active, -> {where(:active => true)}
end
