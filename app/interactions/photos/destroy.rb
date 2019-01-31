module Photos
  class Destroy < ActiveInteraction::Base
    integer :id
    with_options default: nil do
      integer :user_id
      string :access_token
    end

    validates :id, presence: true
    validate :you_can_remove_photo?, unless: :valid_photo_exists?

    def execute
      Photo.find_by(id: id).destroy
    end

    private

    def user
      @user ||= if user_id.present?
                  User.find(user_id)
                else
                  User.find_by(access_token: access_token)
                end
    end

    def you_can_remove_photo?
      errors.add(:photo, 'You can not remove this photo. You can remove only your photo!') if Photo.where(id: id, user_id: user.id).blank?
    end

    def valid_photo_exists?
      errors.add(:photo, 'Photo not found') if Photo.where(id: id).blank?
    end
  end
end
