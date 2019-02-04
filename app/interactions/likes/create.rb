module Likes
  class Create < ActiveInteraction::Base
    integer :photo_id
    string :access_token

    validate :check_user, :check_photo, :check_unique_like, :check_valid_like

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
      errors.add(:user, 'User not found') unless user
    end

    def check_photo
      errors.add(:photo, 'Photo not found') unless photo
    end

    def check_unique_like
      errors.add(:like, 'Like alredy exist!') if Like.find_by(photo_id: photo.id, user_id: user.id)
    end

    def check_valid_like
      errors.add(:like, 'You can not like your photo!') if photo.user_id == user.id
    end
  end
end
