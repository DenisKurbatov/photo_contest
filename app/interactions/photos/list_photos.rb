class ListPhotos < ActiveInteraction::Base
  string :sorting
  string :search, default: nil

  def execute
    photos = Photo.approved.order(sorting)
    photos = photos.where("name ILIKE '%#{search}%'") unless search.nil?
    photos
  end
end
