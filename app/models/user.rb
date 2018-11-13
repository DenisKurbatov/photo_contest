# == Schema Information
#
# Table name: users
#
#  id                  :bigint(8)        not null, primary key
#  remember_created_at :datetime
#  uid                 :string
#  provider            :string
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_uid  (uid) UNIQUE
#

class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable, omniauth_providers: %i[vkontakte github]
  has_many :comments, dependent: :nullify
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.update_access_token
    access_token = SecureRandom.urlsafe_base64(32)
    generate_access_token if User.exists?(access_token: access_token)
    access_token
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.provider = auth.provider
      user.email = auth.info.email
      if user.provider == 'vkontakte'
        user.image = auth.extra.raw_info.photo_400_orig
        user.url = auth.info.urls.Vkontakte
      else
        user.image = auth.info.image
        user.url = auth.info.urls.GitHub
      end
    end
  end
end
