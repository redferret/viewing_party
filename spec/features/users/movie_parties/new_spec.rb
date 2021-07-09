require 'rails_helper'

RSpec.describe 'Creating a movie party page' do
  before :each do
    @main_user = FactoryBot.create(:user)
    @friend_1 = FactoryBot.create(:user, email: 'friend1@test.com')
    @friend_2 = FactoryBot.create(:user, email: 'friend2@test.com')
    @friend_3 = FactoryBot.create(:user, email: 'friend3@test.com')

    @main_user.friends << @friend_1 << @friend_2 << @friend_3

    login_with @main_user

    visit new_movie_party_path(movie_id: 0)
  end

  describe 'movie details form' do
    it 'has a title' do
      save_and_open_page
      expect(page).to have_content('Movie Party Details')
    end

    it 'has all the fields to make a movie party' do
      within '#movie-details' do
        expect(page).to have_field('movie_title', with: 'Fight Club')
        expect(page).to have_field('duration_of_party')
        expect(page).to have_field('duration_of_party')
        expect(page).to have_field('time_of_viewing')
        expect(page).to have_button('Create Party')
      end
    end
  end

  describe 'friends list in form' do
    it 'has the list of friends to add to the party' do
      within '#friends-list' do
        expect(page).to have_content(@friend_1.email)
        expect(page).to have_content(@friend_2.email)
        expect(page).to have_content(@friend_3.email)
      end
      within "#friend-#{@friend_1.id}" do
        expect(page).to have_field('', type: 'checkbox')
      end
    end
  end
end