class MovieParty < ApplicationRecord
  belongs_to :user
  has_many :invitations, dependent: :destroy

  def viewing_date
    date = DateTime.parse(time_date.to_s)
    date.strftime('View on: %F')
  end

  def viewing_time
    date = DateTime.parse(time_date.to_s)
    date.strftime('At: %H:%M')
  end
end
