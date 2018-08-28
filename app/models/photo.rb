class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  belongs_to :user
  has_many :likes, dependent: :destroy
  attr_accessor :name
end
