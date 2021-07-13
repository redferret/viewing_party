require 'rails_helper'

RSpec.describe MoviesAPI::Client do
  describe 'API Call' do
    describe '::trending_movies' do
      it 'returns movies trending for the week' do
        trending_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::trending_movies_endpoint)
        trending_movies_mock_data = MoviesAPIMock::get('trending_movies.json')
        stub_request(:get, trending_movies_mock_path)
          .with(headers: test_headers).to_return(status: 200, body: trending_movies_mock_data, headers: {})

        movies = MoviesAPI::Client.trending_movies

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'Avengers: Infinity War'
        expect(movies.first[:vote_average]).to eq 8.3
      end
    end

    describe '::top_rated_movies' do
      it 'returns the results for top rated movies' do
        top_rated_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::top_rated_movies_endpoint)
        top_movies_mock_data = MoviesAPIMock::get('top_rated_movies.json')
        stub_request(:get, top_rated_movies_mock_path)
          .with(headers: test_headers).to_return(status: 200, body: top_movies_mock_data, headers: {})

        movies = MoviesAPI::Client.top_rated_movies

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'The Shawshank Redemption'
        expect(movies.first[:vote_average]).to eq 8.32
      end
    end

    describe '::search_by_title' do
      it 'returns the search results for movies' do
        search_by_title_mock_path = EndpointStitch::stitch(MoviesAPI::Client::search_by_title_endpoint) << '&query=Movie%20Title'
        search_movies_mock_data = MoviesAPIMock::get('search_movie_result.json')
        stub_request(:get, search_by_title_mock_path)
          .with(headers: test_headers).to_return(status: 200, body: search_movies_mock_data, headers: {})

        movies = MoviesAPI::Client.search_by_title('Movie Title')

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'The Avengers'
        expect(movies.first[:vote_average]).to eq 7.33
      end
    end

    describe '::movie_details' do
      it 'returns deatils of a specific movie' do
        movie_details_mock_path = EndpointStitch::stitch(MoviesAPI::Client::movie_details_endpoint(550)) << '&append_to_response=credits,reviews'
        movie_details_mock_data = MoviesAPIMock::get('movie_details.json')
        stub_request(:get, movie_details_mock_path)
          .with(headers: test_headers).to_return(status: 200, body: movie_details_mock_data, headers: {})

        movies = MoviesAPI::Client.movie_details(550)

        expect(movies).to be_a Hash
        expect(movies[:title]).to eq("Fight Club")
        expect(movies[:id]).to eq(550)
        expect(movies[:credits]).to be_a Hash
        expect(movies[:credits][:cast]).to be_a Array
        expect(movies[:credits][:cast].first[:name]).to eq("Edward Norton")
        expect(movies[:credits][:cast].first[:character]).to eq("The Narrator")
        expect(movies[:credits][:cast].second[:name]).to eq("Brad Pitt")
        expect(movies[:credits][:cast].second[:character]).to eq("Tyler Durden")
        expect(movies[:reviews][:results]).to be_an Array
        expect(movies[:reviews][:results].first[:author]).to eq("Goddard")
        expect(movies[:reviews][:results].first[:content]).to be_a String
      end
    end

    describe '::upcoming_movies' do
      it 'returns upcoming movie details' do
        upcoming_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::upcoming_movies_endpoint)
        upcoming_movies_mock_data = MoviesAPIMock::get('upcoming_movies.json')
        stub_request(:get, upcoming_movies_mock_path)
          .with(headers: test_headers).to_return(status: 200, body: upcoming_movies_mock_data, headers: {})

        movies = MoviesAPI::Client.upcoming_movies

        expect(movies).to be_an Array
        expect(movies.first[:poster_path]).to eq("/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg")
        expect(movies.first[:release_date]).to eq("2016-09-02")
        expect(movies.first[:title]).to eq("The Light Between Oceans")
      end
    end
  end
end
