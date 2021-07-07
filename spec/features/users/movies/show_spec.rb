require 'rails_helper'

RSpec.describe 'Discover movies page' do
  before :each do
    user = FactoryBot.create(:user)
    login_with(user)

    visit discover_path
  end

  describe 'searching for a movie button and form' do
    it 'has a field to search movies by' do
      expect(page).to have_link 'Find Top Rated Movies'
    end

    it 'has a button to find top rated movies' do
      within 'form' do
        expect(page).to have_field 'movie_title'
        expect(page).to have_button 'Find Movies'
      end
    end
  end
end
