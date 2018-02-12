class Coin < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :picture, presence: true
  has_many :comments
  belongs_to :user
end
