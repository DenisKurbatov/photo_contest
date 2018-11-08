class PhotoSerializer < ActiveModel::Serializer
  attributes :name, :image_url, :user_id, :likes_count, :comments_count, :comments

  has_many :comments

  def image_url
    object.image.url
  end
  def comments_count
    object.comments_count
  end
end
