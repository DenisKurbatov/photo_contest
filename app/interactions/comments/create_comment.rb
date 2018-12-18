class CreateComment < ActiveInteraction::Base
  string :comment_parent_type, default: 'photo'
  string :body
  integer :user_id, :comment_parent_id

  validates :body, presence: true, length: { in: 3..300 }
  def to_model
    Comment.new
  end

  def execute
    comment_parent = Photo.find(comment_parent_id) if comment_parent_type == 'photo'
    comment_parent = Comment.find(comment_parent_id) if comment_parent_type == 'comment'
    comment = comment_parent.comments.new(inputs)
    errors.merge!(comment.errors) unless comment.save
    comment
  end
end
