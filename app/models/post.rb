class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments , dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  paginates_per 3
  has_many :ratings ,dependent: :destroy
  has_one_attached :image
  has_many :posts_users_read_statuses
  has_many :readers, through: :posts_users_read_statuses, source: :user
  def marked_as_read?(user)
    readers.includes([:readers]).include?(user)
  end

  def mark_as_read(user)
    posts_users_read_statuses.find_or_create_by(user: user).update(read: true)
  end
end
