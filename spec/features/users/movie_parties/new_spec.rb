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
      expect(page).to have_content('Movie Party Details')
    end

    it 'has all the fields to make a movie party' do
      within '#movie-details' do
        expect(page).to have_field('movie_title', with: 'Fight Club')
        expect(page).to have_field('time_of_viewing')
        expect(page).to have_field('duration_of_party')
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
        expect(page).to have_field("friends[email_#{@friend_1.id}]", type: 'checkbox')
      end
    end
  end

  describe 'creating a party,' do
    context 'successful creation' do
      it 'navigates user back to the dashboard with the movie party visible as a host' do
        within '#movie-details' do
          fill_in 'time_of_viewing', with: '2:00'
          check "friends[email_#{@friend_1.id}]"
          click_button 'Create Party'
        end

        expect(current_path).to eq dashboard_path

        movie_party = MovieParty.first

        within "#movie-party-#{movie_party.id}" do
          expect(page).to have_content('Hosting')
          expect(page).to have_content(movie_party.movie_title)
          expect(page).to have_content(movie_party.viewing_date)
          expect(page).to have_content(movie_party.viewing_time)
        end
      end
    end
  end
end
