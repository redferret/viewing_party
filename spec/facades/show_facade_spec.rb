require 'rails_helper'

RSpec.describe Movies::ShowFacade do
  before :each do
    movie_details_mock_path = EndpointStitch::stitch(MoviesAPI::Client::movie_details_endpoint(550)) << '&append_to_response=credits,reviews'
    movie_details_mock_data = MoviesAPIMock::get('movie_details.json')
    stub_request(:get, movie_details_mock_path)
      .with(headers: test_headers).to_return(status: 200, body: movie_details_mock_data, headers: {})
  end

  describe 'method' do
    context '::movie_details' do
      it 'returns an array of Poros::Movies' do
        movies = Movies::ShowFacade.movie_details(550)

        expect(movies).to be_a Poros::MovieDetails
      end
    end
  end
end
