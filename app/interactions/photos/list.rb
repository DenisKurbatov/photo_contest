module Photos
  class List < ActiveInteraction::Base
    string :sorting, default: 'id asc'
    string :search, default: nil
    integer :user_id, default: nil

    def execute
      if user_id
        photos = Photo.where(user_id: user_id)
      else
        photos = Photo.approved.order(sorting)
        photos = photos.where("name ILIKE '%#{search}%'") unless search.nil?
      end
      photos
    end
  end
end
