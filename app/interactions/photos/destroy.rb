module Photos
  class Destroy < ActiveInteraction::Base
    integer :user_id, :photo_id, base: 10

    validates :photo_id, :user_id, presence: true
    validate :you_can_remove_photo?, unless: :valid_photo_exists?

    def execute
      Photo.find_by(id: photo_id).destroy
    end

    private

    def you_can_remove_photo?
      errors.add(:no_rights, 'You can not remove this photo. You can remove only your photo!') if Photo.where(id: photo_id, user_id: user_id).blank?
    end

    def valid_photo_exists?
      errors.add(:photo, 'Photo not found') if Photo.where(id: photo_id).blank?
    end
  end
end
