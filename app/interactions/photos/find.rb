module Photos
  class Find < ActiveInteraction::Base
    integer :id

    def execute
      Photo.find_by(id)
    end
  end
end
