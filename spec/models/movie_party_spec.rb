require 'rails_helper'

RSpec.describe MovieParty do
  it {should belong_to :user}
  it {should have_many :invitations}
end
