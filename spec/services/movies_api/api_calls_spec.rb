require 'rails_helper'

RSpec.describe 'API Calls' do
  describe 'api call,' do
    describe '::top_rated_movies' do
      it 'returns the results for top rated movies' do
        movies = MoviesAPI::Client.top_rated_movies

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'The Shawshank Redemption'
        expect(movies.first[:vote_average]).to eq 8.32
      end
    end

    describe '::search_by_title' do
      it 'returns the search results for movies' do
        movies = MoviesAPI::Client.search_by_title('Movie Title')

        expect(movies).to be_an Array
        expect(movies.first[:title]).to eq 'The Avengers'
        expect(movies.first[:vote_average]).to eq 7.33
      end
    end

    describe '::movie_details' do
      it 'returns deatils of a specific movie' do
        movie = MoviesAPI::Client.movie_details(550)

        expect(movie).to be_a Hash
        expect(movie[:title]).to eq("Fight Club")
        expect(movie[:id]).to eq(550)
      end
    end

    describe '::movie_credits' do
      it 'returns credits for a specific movie' do
        movie = MoviesAPI::Client.movie_credits(550)

        expect(movie).to be_a Hash
        expect(movie[:cast].first[:name]).to eq("Edward Norton")
        expect(movie[:cast].first[:character]).to eq("The Narrator")
        expect(movie[:cast].second[:name]).to eq("Brad Pitt")
        expect(movie[:cast].second[:character]).to eq("Tyler Durden")
      end
    end

    describe '::movie_reviews' do
      it 'returns reviews for a specific movie' do
        movies = MoviesAPI::Client.movie_reviews(550)

        expect(movies).to be_an Array
        expect(movies.first[:author]).to eq("Cat Ellington")
        expect(movies.first[:content]).to be_a String
      end
    end

    describe '::upcoming_movies' do
      it 'returns upcoming movie details' do
        movies = MoviesAPI::Client.upcoming_movies

        expect(movies).to be_an Array
        expect(movies.first[:poster_path]).to eq("/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg")
        expect(movies.first[:release_date]).to eq("2016-09-02")
        expect(movies.first[:title]).to eq("The Light Between Oceans")
      end
    end
  end
end
