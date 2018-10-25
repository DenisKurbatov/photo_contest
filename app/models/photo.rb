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
  has_many :comments, as: :comment_parent, dependent: :destroy

  validates :name, presence: true
  validates :image, presence: true

  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :banned, -> { where(aasm_state: :banned) }
  scope :approved, -> { where(aasm_state: :approved) }
  scope :moder, -> { where(aasm_state: :moder) }

  paginates_per 8

  aasm do
    state :moder, initial: true
    state :approved
    state :banned
    state :removed

    event :approve do
      transitions from: %i[moder banned], to: :approved
    end

    event :ban do
      transitions from: :moder, to: :banned
    end

    event :remove, before_transaction: :past_state_save do
      transitions from: %i[moder approved banned], to: :removed
    end

    event :cancel_remove, before_transaction: :past_state do
      transitions from: :removed, to: :approved, guard: :approved?
      transitions from: :removed, to: :banned, guard: :banned?
      transitions from: :removed, to: :moder, guard: :moder?
    end
  end
  def past_state_save
    PastState.rank_member(id, 1, { past_state: aasm.current_state }.to_json)
  end

  def past_state
    @past_state = JSON.parse(PastState.member_data_for(id))['past_state'].to_sym
    PastState.remove_member(id)
  end

  def moder?
    @past_state == :moder
  end

  def banned?
    @past_state == :banned
  end

  def approved?
    @past_state == :approved
  end
end
