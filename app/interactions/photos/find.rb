module Photos
  class Find < ActiveInteraction::Base
    integer :id

    validate :photo_exists?

    def execute
      Photo.find_by(id: id)
    end

    private

    def photo_exists?
      errors.add(:photo, 'Photo not found') if Photo.where(id: id).blank?
    end
  end
end
