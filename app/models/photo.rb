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
  include AASM

  mount_uploader :image, PhotoUploader
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, as: :comment_parent


  validates :name, presence: true
  validates :image, presence: true

  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :banned, ->{ where(aasm_state: :banned) }
  scope :approved, ->{ where(aasm_state: :approved) }
  scope :moder, ->{ where(aasm_state: :moder) }

  paginates_per 8


  aasm do
    state :moder, initial: true
    state :approved
    state :banned

    event :approve do
      transitions from: [:moder, :banned], to: :approved
    end

    event :ban do
      transitions from: [:moder, :approved], to: :banned
    end
  end

  
end
