class Like < ApplicationRecord
  belongs_to :user
  belongs_to :photo, counter_cache: :likes_count
end
