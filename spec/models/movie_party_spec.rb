require 'rails_helper'

RSpec.describe MovieParty do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :invitations}
  end  
end
