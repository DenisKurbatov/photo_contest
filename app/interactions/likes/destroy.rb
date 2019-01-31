module Likes
  class Destroy < ActiveInteraction::Base
    integer :photo_id
    string :access_token

    validates :photo_id, presence: true
    validate :validate_like_exists?

    attr_reader :count

    set_callback :execute, :after, -> { @count = Photo.find_by(id: photo_id).likes_count }

    def execute
      Like.find_by(user_id: user.id, photo_id: photo_id).destroy
    end

    private

    def user
      @user ||= User.find_by(access_token: access_token)
    end

    def validate_like_exists?
      errors.add(:like, 'like not found ( you not like this photo)') unless Like.where(user_id: user.id, photo_id: photo_id).exists?
    end
  end
end
