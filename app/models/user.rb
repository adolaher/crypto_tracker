class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :coins, dependent: :destroy
  has_many :comments, dependent: :destroy

  def admin?
    role == "admin"
  end

  mount_uploader :avatar, AvatarUploader
end
