module Likes
  class Create < ActiveInteraction::Base
    integer :photo_id
    string :access_token

    validate :check_user, :check_photo
    validate :check_unique_like, :check_valid_like, if: :photo && :user

    set_callback :execute, :after, -> { @count = Photo.find_by(id: photo_id).likes_count }

    def execute
      { like_id: like.id,
        photo_id: photo.id,
        likes_count: photo.likes.count }
    end

    private

    def like
      @like ||= Like.create(user_id: user.id, photo_id: photo_id)
    end

    def photo
      @photo ||= Photo.find_by(id: photo_id)
    end

    def user
      @user ||= User.find_by(access_token: access_token)
    end

    def check_user
      raise Error::ApplicationError.new('UserError', 401, 'User is not authorized!') unless user
    end

    def check_photo
      raise Error::ApplicationError.new('PhotoError', 404, 'Photo not found!') unless photo
    end

    def check_unique_like
      raise Error::ApplicationError.new('LikeError', 422, 'Like alredy exist!') if Like.find_by(photo_id: photo.id, user_id: user.id)
    end

    def check_valid_like
      raise Error::ApplicationError.new('LikeError', 422, 'You can not like your photo!') if photo.user_id == user.id
    end
  end
end
