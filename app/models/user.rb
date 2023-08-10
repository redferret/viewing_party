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

  def updated_movie_parties
    movie_parties.each do |movie_party|
      movie_party.destroy if movie_party.time_date < DateTime.now - 1.day
    end
    movie_parties.reload.order(:time_date)
  end

  def remove_friend(friend)
    friendship = friendships.find_by(friend_id: friend.id)
    Invitation.where(friendship_id: friendship.id).destroy_all
    friends.delete(friend)
  end
end
