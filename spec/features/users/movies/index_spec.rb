require 'rails_helper'

RSpec.describe 'Discover movies page' do
  before :each do
    user = FactoryBot.create(:user)
    login_with(user)

    visit discover_path
  end

  describe 'searching for top rated movies' do
    it 'has a link to search for top movies' do
      expect(page).to have_link 'Find Top Rated Movies'
    end

    it 'returns list of top rated movies' do
      click_link 'Find Top Rated Movies'

      expect(current_path).to eq movies_path
      within '#movies-list' do
        expect(page).to have_link('The Shawshank Redemption')
        expect(page).to have_content('Vote Average: 8.32')
        expect(page).to have_link('Whiplash')
        expect(page).to have_content('Vote Average: 8.29')
      end
    end
  end
  
  describe 'search trending movies,' do
    it 'has a link to find trending movies' do
      expect(page).to have_link 'Find Trending Movies'
    end
    
    it 'returns list of trending movies' do
      click_link 'Find Trending Movies'
    
      expect(current_path).to eq movies_path

      within '#movies-list' do
        expect(page).to have_link('Avengers: Infinity War')
        expect(page).to have_content('Vote Average: 8.3')

        expect(page).to have_link('Deadpool 2')
        expect(page).to have_content('Vote Average: 7.6')
      end
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
      
      within '#movies-list' do
        expect(page).to have_link('The Avengers')
        expect(page).to have_content('Vote Average: 7.33')
        expect(page).to have_link('Avengers: Age of Ultron')
        expect(page).to have_content('Vote Average: 7.4')
      end
    end
  end
end
