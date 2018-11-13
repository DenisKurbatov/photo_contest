class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :author_name, :body, :created_at

  belongs_to :photo
end
