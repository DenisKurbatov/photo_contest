class DestroyLike < ActiveInteraction::Base
  integer :like_id
  integer :user_id

  validates :like_id, :user_id, presence: true
  validate :can_remove?, unless: :validate_like_exists?

  def execute
    @like.destroy!
  end

  private

  def validate_like_exists?
    @like = Like.find_by(id: like_id)
    errors.add(:like_id, 'like not found') if @like.blank?
  end

  def can_remove?
    return true if @like.user_id == user_id

    errors.add(:can_not_remove, 'You can not remove this like! You can remove only your photos!')
    false
  end
end
