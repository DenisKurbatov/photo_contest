class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :author_name, :likes_count, :comments_count, :all_comments_count
  has_many :comments
end
