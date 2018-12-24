module Photos
  class Destroy < ActiveInteraction::Base
    object :photo
    def execute
      photo.destroy
    end
  end
end
