module Photos
  class Destroy < ActiveInteraction::Base
    integer :id
    with_options default: nil do
      integer :user_id
      string :access_token
    end

    validate :you_can_remove_photo, unless: :check_user && :check_photo

    def execute
      Photo.find_by(id: id)&.destroy
    end

    private

    def user
      @user ||= if user_id.present?
                  User.find_by(id: user_id)
                else
                  User.find_by(access_token: access_token)
                end
    end

    def photo
      @photo ||= Photo.find_by(id: id)
    end

    def check_user
      errors.add(:user, 'User not found') unless user
    end

    def check_photo
      errors.add(:photo, 'Photo not found') unless photo
    end

    def you_can_remove_photo
      errors.add(:photo, 'You can not remove this photo. You can remove only your photo!') unless photo.user_id == user.id
    end
  end
end
