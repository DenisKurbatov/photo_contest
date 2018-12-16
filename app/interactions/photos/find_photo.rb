class FindPhoto < ActiveInteraction::Base
  integer :id 

  def execute
    photo = Photo.find_by_id(id)
  end

end
