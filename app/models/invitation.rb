class Invitation < ApplicationRecord
  belongs_to :movie_party
  belongs_to :friendship
end
