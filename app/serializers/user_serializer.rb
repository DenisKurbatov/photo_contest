class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :provider, :email, :url
end
