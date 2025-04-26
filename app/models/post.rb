class Post < ApplicationRecord
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :text, presence: true
  validates :created_at, presence: true
end
