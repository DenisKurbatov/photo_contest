module Photos
  class Find < ActiveInteraction::Base
    integer :id

    def execute
      raise Error::ApplicationError.new('PhotoError', 404, 'Photo not found!') unless photo
      photo
    end

    private

    def photo
      @photo ||= Photo.find_by(id: id)
    end
  end
end
