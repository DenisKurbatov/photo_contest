# == Schema Information
#
# Table name: likes
#
#  id         :bigint(8)        not null, primary key
#  photo_id   :bigint(8)
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_likes_on_photo_id              (photo_id)
#  index_likes_on_photo_id_and_user_id  (photo_id,user_id) UNIQUE
#  index_likes_on_user_id               (user_id)
#

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
