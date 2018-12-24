module Comments
  class Create < ActiveInteraction::Base
    string :comment_parent_type, default: 'photo'
    string :body
    integer :user_id, :comment_parent_id, :photo_id, base: 10

    validates :body, presence: true, length: { in: 3..300 }
    validates :user_id, :comment_parent_id, :photo_id, presence: true
    validate :valid_photo_exists?

    def execute
      comment = comment_parent.comments.new(user_id: user_id, body: body)
      if comment.save
        update_all_comments_count
      else
        errors.merge!(comment.errors)
      end
      comment
    end

    private

    def update_all_comments_count
      new_count = Photo.find_by(id: photo_id).all_comments_count + 1
      Photo.update(photo_id, all_comments_count: new_count)
    end

    def comment_parent
      parent = if comment_parent_type == 'comment'
                 Comment.find_by(id: comment_parent_id)
               else
                 Photo.find_by(id: photo_id)
               end
      parent
    end

    def valid_photo_exists?
      errors.add(:photo, 'Photo not found!') if Photo.where(id: photo_id).blank?
    end
  end
end
