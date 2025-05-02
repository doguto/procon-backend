class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_many :follower_relationships,
           foreign_key: :followed_id,
           class_name: "Follow",
           inverse_of: :followed,
           dependent: :destroy

  has_many :followee_relationships,
           foreign_key: :follower_id,
           class_name: "Follow",
           inverse_of: :follower,
           dependent: :destroy

  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following, through: :followee_relationships, source: :followed

  has_many :inverse_follows,
           foreign_key: :follower_id,
           class_name: "Follow",
           dependent: :destroy,
           inverse_of: :follower

  has_many :follows,
           foreign_key: :followed_id,
           class_name: "Follow",
           dependent: :destroy,
           inverse_of: :followed
end
