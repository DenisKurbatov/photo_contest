class CreateLike < ActiveInteraction::Base
  integer :photo_id, :user_id

  def execute
    like = Like.new(inputs)
    errors.merge!(photo.errors) unless like.save!
    like
  end
end
