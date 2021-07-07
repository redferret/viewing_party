require 'rails_helper'

RSpec.describe 'Discover movies page' do
  before :each do
    user = FactoryBot.create(:user)
    login_with(user)

    visit discover_path
  end

  describe 'searching for top rated movies' do
    it 'has a field to search for top movies' do
      expect(page).to have_link 'Find Top Rated Movies'
    end
  end

  describe 'searching for movies by title' do
    it 'has a button to find movies by search query' do
      within 'form' do
        expect(page).to have_field 'movie_title'
        expect(page).to have_button 'Find Movies'
      end
    end

    it 'returns list of movies from an API call' do
      within 'form' do
        fill_in 'movie_title', with: 'Movie Title'
        click_button 'Find Movies'
      end

      expect(current_path).to eq movies_path
    end
  end
end
