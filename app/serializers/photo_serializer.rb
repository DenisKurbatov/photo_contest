class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :author, :likes_count, :comments_count

  has_many :comments

  def author
    { id: object.user_id, name: object.author_name }
  end

  def comments_count
    object.comments_count
  end
end
