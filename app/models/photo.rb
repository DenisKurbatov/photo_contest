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
  has_paper_trail only: [:status], on: :update
  include AASM

  delegate :name, to: :user, allow_nil: true, prefix: :author
  delegate :url, to: :user, allow_nil: true, prefix: :author

  mount_uploader :image, PhotoUploader

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, as: :comment_parent, dependent: :destroy

  validates :name, :image, presence: true

  scope :by_user, ->(user_id) { where(user_id: user_id) }

  paginates_per 8

  aasm column: :status do
    state :moder, initial: true
    state :approved
    state :banned
    state :removed

    event :approve do
      transitions from: %i[moder banned removed], to: :approved
    end

    event :ban do
      transitions from: %i[moder removed], to: :banned
    end

    event :remove, after_transaction: :remove_photo_worker  do
      transitions from: %i[moder approved banned removed], to: :removed
    end
    event :moder do
      transitions from: :removed, to: :moder
    end
    
  end
  def comments_count(comment_parent = self)
    count = comment_parent.comments.count
    return 0 if count ==0 
    comment_parent.comments.each do |comment|
      count += comments_count(comment)
    end
    count
  end

  def remove_photo_worker
    RemovePhotoWorker.perform_in(2.minutes, id)
  end
end
