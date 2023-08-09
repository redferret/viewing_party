require 'rails_helper'

RSpec.describe 'Discover movies page' do
  before :each do
    trending_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::trending_movies_endpoint)
    trending_movies_mock_data = MoviesAPIMock::get('trending_movies.json')
    stub_request(:get, trending_movies_mock_path)
      .with(headers: test_headers).to_return(status: 200, body: trending_movies_mock_data, headers: {})
      
    top_rated_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::top_rated_movies_endpoint)
    top_movies_mock_data = MoviesAPIMock::get('top_rated_movies.json')
    stub_request(:get, top_rated_movies_mock_path)
      .with(headers: test_headers).to_return(status: 200, body: top_movies_mock_data, headers: {})

    upcoming_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::upcoming_movies_endpoint)
    upcoming_movies_mock_data = MoviesAPIMock::get('upcoming_movies.json')
    stub_request(:get, upcoming_movies_mock_path)
      .with(headers: test_headers).to_return(status: 200, body: upcoming_movies_mock_data, headers: {})

    search_by_title_mock_path = EndpointStitch::stitch(MoviesAPI::Client::search_by_title_endpoint) << '&query=Movie%20Title'
    search_movies_mock_data = MoviesAPIMock::get('search_movie_result.json')
    stub_request(:get, search_by_title_mock_path)
      .with(headers: test_headers).to_return(status: 200, body: search_movies_mock_data, headers: {})

    user = create(:user)
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

    describe 'search upcoming movies,' do
      it 'has a link to find upcoming movies' do
        expect(page).to have_link 'Find Upcoming Movies'
      end

      it 'returns list of trending movies' do
        click_link 'Find Upcoming Movies'

        expect(current_path).to eq movies_path

        within '#movies-list' do
          expect(page).to have_link("The Light Between Oceans")
          expect(page).to have_content('Vote Average: 4.41')

          expect(page).to have_link("Keanu")
          expect(page).to have_content('Vote Average: 6.04')
        end
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
