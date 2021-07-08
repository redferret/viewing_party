class Invitation < ApplicationRecord
  belongs_to :movie_party
  belongs_to :friendship

  def self.find_invitations(user_id)
    joins(:friendship, :movie_party)
      .select('invitations.*', 'movie_parties.*', 'friendships.friend_id as friend_user_id')
      .where('friendships.friend_id = ?', user_id)
  end
end


# MovieParty.joins(:invitations, :friendships).select('invitations.*', 'movie_parties.*', 'friendships.friend_id as friend_user_id').where('invitaions.friendship_id' == 1)
# Invitation.joins(:friendship, :movie_party).select('invitations.*', 'movie_parties.*', 'friendships.friend_id as friend_user_id').where('invitaions.friendship_id' == 1)
