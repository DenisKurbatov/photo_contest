module Comments
  class Create < ActiveInteraction::Base
    string :comment_parent_type, default: 'Photo'
    string :body
    integer :photo_id
    string :access_token, default: nil
    integer :user_id, :comment_parent_id, default: nil

    validates :body, length: { in: 3..300 }
    validate :check_user, :check_photo


    def execute
      comment.valid? ? update_all_comments_count : errors.merge!(comment.errors)
    end

    private

    def comment
      @comment ||= comment_parent.comments.create(user_id: user.id, body: body)
    end

    def update_all_comments_count
      photo.increment!(:all_comments_count)
      comment
    end

    def user
      @user ||= if user_id.present?
                  User.find_by(id: user_id)
                else
                  User.find_by(access_token: access_token)
                end
    end

    def photo
      @photo ||= Photo.find_by(id: photo_id)
    end

    def comment_parent
      parent = if comment_parent_type == 'Comment'
                 Comment.find_by(id: comment_parent_id)
               else
                 Photo.find_by(id: photo_id)
               end
      parent
    end

    def check_user
      raise Error::ApplicationError.new('UserError', 401, 'User is not authorized!') unless user
    end

    def check_photo
      raise Error::ApplicationError.new('PhotoError', 404, 'Photo not found!') unless photo
    end
  end
end
