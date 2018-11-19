class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :comment_parent, polymorphic: true, counter_cache: :comments_count
  has_many :comments, as: :comment_parent, dependent: :destroy

  scope :get_comments, ->(type, id) { where(comment_parent_type: type, comment_parent_id: id) }

  delegate :name, to: :user, allow_nil: true, prefix: :author
end
