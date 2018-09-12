class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  belongs_to :user
  has_many :likes, dependent: :destroy

  scope :from_user, ->(user_id) { where(user_id: user_id) }
  attr_accessor :name
end
