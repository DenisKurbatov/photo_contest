class FindPhoto < ActiveInteraction::Base
  integer :id

  def execute
    photo = Photo.find_by(id)
  end
end
