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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:vkontakte]
  has_many :comments
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.provider = auth.provider
      user.image = auth.info.image
    end
    
  end

end
