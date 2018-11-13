class ListPhotos < ActiveInteraction::Base
  string :sorting

  def execute
    Photo.approved.order(sorting)
  end
end