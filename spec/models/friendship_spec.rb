require 'rails_helper'

RSpec.describe Friendship do

  describe "relationships" do
    it {should belong_to :user}
    it {should belong_to :friend}
    it {should have_many :invitations}
  end
end
