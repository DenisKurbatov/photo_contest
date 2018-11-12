class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :user_id, :likes_count, :comments_count

  has_many :comments
  
  def comments_count
    object.comments_count
  end
end
