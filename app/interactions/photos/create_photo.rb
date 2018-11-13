class CreatePhoto < ActiveInteraction::Base
  string :name
  file :image
  object :user

  def to_model
    Photo.new
  end

  def execute
    photo = Photo.new(inputs)
    unless photo.save!
      errors.merge!(photo.errors)
    end
    photo
  end

end