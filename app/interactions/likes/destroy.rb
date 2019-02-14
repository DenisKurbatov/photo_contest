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
      raise Error::ApplicationError.new('UserError', 401, 'User is not authorized!') unless user
    end

    def check_photo
      raise Error::ApplicationError.new('PhotoError', 404, 'Photo not found!') unless photo
    end
  end
end
