module Likes
  class Create < ActiveInteraction::Base
    integer :photo_id
    string :access_token

    validate :check_like_existance, :valid_photo_exists?, :user_exist?

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
      @photo ||= Photo.find(photo_id)
    end

    def user
      @user ||= User.find_by(access_token: access_token)
    end

    def user_exist?
      errors.add(:base, 'User not found') unless user
    end

    def check_like_existance
      errors.add(:uniquenes, 'You already like this photo!') if Like.where(photo_id: photo.id, user_id: user.id).exists?
    end

    def valid_photo_exists?
      errors.add(:like, 'You can not like your photo!') if photo.user_id == user.id
    end
  end
end
