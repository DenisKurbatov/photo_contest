class PhotoSerializer < ActiveModel::Serializer
  attributes :name, :image_url, :user_id, :likes_count, :comments_count
  
  def comments
    CommentSerializer.new(object.comments).as_json
  end
  def comments_count
    object.comments_count
  end
end
