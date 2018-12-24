module Photos
  class Find < ActiveInteraction::Base
    integer :photo_id, base: 10

    validate :photo_exists?

    def execute
      Photo.find_by(id: photo_id)
    end

    private

    def photo_exists?
      errors.add(:photo, 'Photo not found') if Photo.where(id: photo_id).blank?
    end

  end
end
