class DestroyLike < ActiveInteraction::Base
  integer :like_id

  def execute
    like = Like.find(like_id)
    like.destroy!
  end
end
