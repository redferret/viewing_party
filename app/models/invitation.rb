class Invitation < ApplicationRecord
  belongs_to :movie_party
  belongs_to :friendship

  def self.find_invitations(user_id)
    joins(:friendship, :movie_party)
      .select('invitations.*', 'movie_parties.movie_poster_path',
              'movie_parties.movie_title', 'movie_parties.time_date',
              'friendships.friend_id as friend_user_id')
      .where('friendships.friend_id = ?', user_id)
  end
end
