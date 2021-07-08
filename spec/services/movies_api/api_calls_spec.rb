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
  end
end
