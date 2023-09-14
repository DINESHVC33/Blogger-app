class Comment < ApplicationRecord
  belongs_to :post
  # belongs_to :topic
  has_one :topic, through: :post
end
