module Photos
  class Create < ActiveInteraction::Base
    string :name
    file :image
    with_options default: nil do
      integer :user_id
      string :access_token
    end

    validates :name, :image, presence: true
    validate :check_user, :name_uniquenes?

    def execute
      photo = Photo.new(name: name, image: image, user_id: user.id)
      errors.merge!(photo.errors) unless photo.save!
      photo
    end

    private

    def user
      @user ||= if user_id.present?
                  User.find_by(id: user_id)
                else
                  User.find_by(access_token: access_token)
                end
    end

    def check_user
      raise Error::ApplicationError.new('UserError', 401, 'User is not authorized!') unless user
    end

    def name_uniquenes?
      errors.add(:uniquenes, 'photo with the same name exists. Please enter another photo') if Photo.where(name: name).exists?
    end
  end
end
