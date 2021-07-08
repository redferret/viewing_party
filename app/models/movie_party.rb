class MovieParty < ApplicationRecord
  belongs_to :user
  has_many :invitations
end
