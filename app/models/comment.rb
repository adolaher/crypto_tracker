class Comment < ApplicationRecord
  validates :title, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5  }
  belongs_to :coin
  belongs_to :user
end
