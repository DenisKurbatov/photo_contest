class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  belongs_to :user, foreign_key: "user_id"
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :from_user, ->(user_id) { where(user_id: user_id) }
  paginates_per 12


  
end
