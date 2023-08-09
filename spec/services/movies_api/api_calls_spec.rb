require 'rails_helper'

RSpec.describe MoviesAPI::Client do
  describe 'API Call' do
    describe '::trending_movies' do
      it 'returns movies trending for the week', :vcr do
        movies = MoviesAPI::Client.trending_movies

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'Spider-Man: Across the Spider-Verse'
        expect(movies.first[:vote_average]).to eq 8.5
      end
    end

    describe '::top_rated_movies' do
      it 'returns the results for top rated movies', :vcr do
        movies = MoviesAPI::Client.top_rated_movies

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'The Godfather'
        expect(movies.first[:vote_average]).to eq 8.7
      end
    end

    describe '::search_by_title' do
      it 'returns the search results for movies', :vcr do
        movies = MoviesAPI::Client.search_by_title('Movie Title')

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'Not Another B Movie'
        expect(movies.first[:vote_average]).to eq 5.8
      end
    end

    describe '::movie_details' do
      it 'returns deatils of a specific movie', :vcr do
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
      it 'returns upcoming movie details', :vcr do
        movies = MoviesAPI::Client.upcoming_movies

        expect(movies).to be_an Array
        expect(movies.first[:poster_path]).to eq("/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg")
        expect(movies.first[:release_date]).to eq("2023-07-19")
        expect(movies.first[:title]).to eq("Barbie")
      end
    end
  end
end
