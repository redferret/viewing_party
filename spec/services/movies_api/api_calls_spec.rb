require 'rails_helper'

RSpec.describe 'API Calls' do
  describe 'api call,' do
    describe '::top_rated_movies' do
      it 'returns the results for top rated movies' do
        movies = MoviesAPI::Client.top_rated_movies

        expect(movies).to be_an Array
        expect(movies.first['title']).to eq 'The Shawshank Redemption'
        expect(movies.first['vote_average']).to eq 8.32
      end
    end

    describe '::search_by_title' do
      it 'returns the search results for movies' do
        movies = MoviesAPI::Client.search_by_title('Movie Title')

        expect(movies).to be_an Array
        expect(movies.first['title']).to eq 'The Avengers'
        expect(movies.first['vote_average']).to eq 7.33
      end
    end

    describe '::movie_details' do
      it 'returns deatils of a specific movie' do
        movie = MoviesAPI::Client.movie_details(0)

        expect(movie).to be_a Hash
        expect(movie['title']).to eq("Fight Club")
        expect(movie['id']).to eq(550)
      end
    end

    describe '::movie_credits' do
      it 'returns credits of a specific movie' do
        movie = MoviesAPI::Client.movie_credits(0)
        # binding.pry

        expect(movie).to be_a Hash
        expect(movie["cast"][0]['name']).to eq("Edward Norton")
        expect(movie["cast"][0]['character']).to eq("The Narrator")
        expect(movie["cast"][1]['name']).to eq("Brad Pitt")
        expect(movie["cast"][1]['character']).to eq("Tyler Durden")
      end
    end

    describe '::movie_reviews' do
      it 'returns credits of a specific movie' do
        movie = MoviesAPI::Client.movie_reviews(0)
        # binding.pry

        expect(movie).to be_a Hash
        expect(movie["results"][0]['author']).to eq("Cat Ellington")
        expect(movie["results"][0]['content']).to be_a String
      end
    end
  end
end
