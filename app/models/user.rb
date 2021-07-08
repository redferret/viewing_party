class User < ApplicationRecord
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :movie_parties, dependent: :destroy

  has_secure_password

  def add_friend(friend)
    friends << friend
  end
end
