class CreatePhoto < ActiveInteraction::Base
  string :name
  file :image
  object :user

  def to_model
    Photo.new
  end

  def execute
    photo = Photo.new(inputs)
    errors.merge!(photo.errors) unless photo.save!
    photo
  end
end
