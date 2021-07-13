require 'rails_helper'

RSpec.describe 'Movies Show page' do
  before :each do
    movie_details_mock_path = EndpointStitch::stitch(MoviesAPI::Client::movie_details_endpoint(550)) << '&append_to_response=credits,reviews'
    movie_details_mock_data = MoviesAPIMock::get('movie_details.json')
    stub_request(:get, movie_details_mock_path)
      .with(headers: test_headers).to_return(status: 200, body: movie_details_mock_data, headers: {})

    @user = FactoryBot.create(:user)
    login_with(@user)

    visit movie_url(550)
  end

  describe 'Show Page' do
    it 'Movie title/ average/ runtime/ genre' do
      within '#title-row' do
        expect(page).to have_content("Fight Club")
      end
      within '#movie-info' do
        expect(page).to have_content("Vote Average: 8.4")
        expect(page).to have_content("Run Time: 139")
        expect(page).to have_content("Genre(s): Drama")
      end
    end

    it 'Has Summary/ Cast/ Reviews' do
      within'#summary' do
        expect(page).to have_content("Summary")
      end
      within '#cast' do
        expect(page).to have_content("Cast")
      end
      within'#reviews' do
        expect(page).to have_content("6 Reviews")
      end
    end
  end

  describe 'create movie party link,' do
    context 'valid navigation' do
      it 'allows user to create a movie party if they have at least 1 friend' do
        @user.friends << FactoryBot.create(:user, email: 'friend@friends.com')
        click_link 'Create Movie Party'

        expect(current_path).to eq new_movie_party_path
      end
    end

    context 'invalid navigation' do
      it 'navigates back to dashboard if user has no friends yet' do
        click_link 'Create Movie Party'

        expect(current_path).to eq dashboard_path
        within '#flash-message' do
          expect(page).to have_content("You can't create a movie party without friends")
        end
      end
    end
  end
end
