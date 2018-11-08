class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :body

  belongs_to :photo
end
