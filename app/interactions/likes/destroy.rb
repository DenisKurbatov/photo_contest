module Likes
  class Destroy < ActiveInteraction::Base
    integer :photo_id
    string :access_token

    validate :check_user, :check_photo

    attr_reader :count

    set_callback :execute, :after, -> { @count = Photo.find_by(id: photo_id)&.likes_count }

    def execute
      Like.find_by(user_id: user.id, photo_id: photo_id)&.destroy
    end

    private

    def user
      @user ||= User.find_by(access_token: access_token)
    end

    def photo
      @photo ||= Photo.find_by(id: photo_id)
    end

    def check_user
      errors.add(:user, 'User not found') unless user
    end

    def check_photo
      errors.add(:photo, 'Photo not found') unless photo
    end
  end
end
