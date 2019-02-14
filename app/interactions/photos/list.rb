module Photos
  class List < ActiveInteraction::Base
    string :sorting, default: 'id asc'
    string :search, default: nil
    integer :user_id, default: nil
    integer :page, default: nil
    integer :per, default: nil

    validate :user_exists?, if: :user_id?

    def execute
      if user_id
        photos = Photo.where(user_id: user_id)
      else
        photos = Photo.approved.order(sorting)
        photos = photos.where("name ILIKE '%#{search}%'") unless search.nil?
      end
      photos.page(page).per(per)
    end

    private

    def user_exists?
      raise Error::ApplicationError.new('UserError', 404, 'User not found!') unless user
    end
  end
end
