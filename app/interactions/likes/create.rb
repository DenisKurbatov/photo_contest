module Likes
  class Create < ActiveInteraction::Base
    integer :photo_id, :user_id, base: 10

    validates :photo_id, :user_id, presence: true
    validate :uniquenes?, :valid_photo_exists?

    attr_reader :count

    set_callback :execute, :after, -> { @count = Photo.find_by(id: photo_id).likes_count }

    def execute
      Like.create(user_id: user_id, photo_id: photo_id)
    end

    private

    def uniquenes?
      errors.add(:uniquenes, 'You already like this photo!') if Like.where(photo_id: photo_id, user_id: user_id).exists?
    end

    def valid_photo_exists?
      if Photo.where(id: photo_id).exists?
        errors.add(:like, 'You can not like your photo!') if Photo.find_by(id: photo_id).user_id == user_id
      else
        errors.add(:photo, 'Photo not found!')
      end
    end
  end
end
