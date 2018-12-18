class CreateLike < ActiveInteraction::Base
  integer :photo_id, :user_id

  validate :uniquenes?, :right?

  def to_model
    Like.new
  end

  def execute
    Like.create(inputs)
  end

  private

  def uniquenes?
    if Like.where(photo_id: photo_id, user_id: user_id).any?
      errors.add(:uniquenes, 'You already like this photo!')
      false
    else
      true
    end
  end

  def right?
    if Photo.find(photo_id).user_id == user_id
      errors.add(:have_no_right, 'You can not like your photo')
      false
    else
      true
    end
  end
end
