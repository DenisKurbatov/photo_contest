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
  has_paper_trail only: [:status], on: :update
  paginates_per 8
  mount_uploader :image, PhotoUploader

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, as: :comment_parent, dependent: :destroy

  validates :name, :image, presence: true

  delegate :name, :url, :email, to: :user, allow_nil: true, prefix: :author

  scope :by_user, ->(user_id) { where(user_id: user_id) }

  aasm column: :status do
    state :moder, initial: true
    state :approved
    state :banned
    state :removed

    event :approve, after_transaction: :send_email_approve do
      transitions from: %i[moder banned removed], to: :approved
    end

    event :ban do
      transitions from: %i[moder removed], to: :banned
    end

    event :remove, after_transaction: :remove_photo_worker do
      transitions from: %i[moder approved banned removed], to: :removed
    end
    event :moder do
      transitions from: :removed, to: :moder
    end
  end

  def remove_photo_worker
    RemovePhotoWorker.perform_in(2.minutes, id)
  end

  def send_email_approve
    UserMailer.with(email: author_email, image: image.file.path).photo_approved.deliver_now
  end
end
