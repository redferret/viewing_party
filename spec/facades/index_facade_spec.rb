require 'rails_helper'

RSpec.describe Movies::IndexFacade do
  before :each do
    trending_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::trending_movies_endpoint)
    trending_movies_mock_data = MoviesAPIMock::get('trending_movies.json')
    stub_request(:get, trending_movies_mock_path)
      .with(headers: test_headers).to_return(status: 200, body: trending_movies_mock_data, headers: {})
  end

  describe 'method' do
    context '::trending_movies' do
      it 'returns an array of Poros::Movies' do
        movies = Movies::IndexFacade.trending_movies
        
        expect(movies).to be_an Array
        expect(movies.first).to be_a Poros::Movie
      end
    end
  end
end
