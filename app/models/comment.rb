class Comment < ApplicationRecord
  belongs_to :post ,dependent: :destroy
  has_one :topic, through: :post
end
