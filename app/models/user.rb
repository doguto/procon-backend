class User < ApplicationRecord
  validates :image, presence: true
  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_many :follower_relationships, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :followee_relationships, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :following, through: :followee_relationships, source: :followed
end
