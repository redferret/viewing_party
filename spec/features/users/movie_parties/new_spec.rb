require 'rails_helper'

RSpec.describe 'Creating a movie party page' do
  before :each do
    @main_user = FactoryBot.create(:user)
    @friend_1 = FactoryBot.create(:user, email: 'friend1@test.com')
    @friend_2 = FactoryBot.create(:user, email: 'friend2@test.com')
    @friend_3 = FactoryBot.create(:user, email: 'friend3@test.com')

    @main_user.friends << @friend_1 << @friend_2 << @friend_3

    login_with @main_user
  end

  describe 'movie details form' do
    it 'has a title'
    it 'has the movie title'
    it 'has duration of the party field'
    it 'has date of the party field'
    it 'has time to watch field'
  end

  describe 'friends list in form' do
    it 'has the list of friends to add to the party'
    it 'has a checkbox near each friend'
  end
  
end