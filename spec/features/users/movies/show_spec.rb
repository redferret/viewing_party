require 'rails_helper'

RSpec.describe 'Movies Show page' do
  before :each do
    user = FactoryBot.create(:user)
    login_with(user)

    visit "/movies/0"
  end

  describe 'Show Page' do
    it 'Movie title/ average/ runtime/ genre' do
      expect(page).to have_content("Fight Club")
      expect(page).to have_content("Vote Average: 7.8")
      expect(page).to have_content("Run Time: 139")
      expect(page).to have_content("Genre(s): Drama")
    end

    it 'Has Summary/ Cast/ Reviews' do
      expect(page).to have_content("Summary")
      expect(page).to have_content("Cast")
      expect(page).to have_content("3 Reviews")
    end
  end
end
