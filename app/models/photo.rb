# == Schema Information
#
# Table name: photos
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  image       :string
#  user_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  likes_count :integer          default(0)
#
# Indexes
#
#  index_photos_on_user_id                 (user_id)
#  index_photos_on_user_id_and_created_at  (user_id,created_at)
#

class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  belongs_to :user, foreign_key: "user_id"
  has_many :likes, dependent: :destroy
  has_many :comments, as: :comment_parent


  validates :name, presence: true
  validates :image, presence: true

  scope :from_user, ->(user_id) { where(user_id: user_id) }
  paginates_per 12


  
end
