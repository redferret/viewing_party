RSpec.configure do |config|
  config.before(:each) do
    test_headers = {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.5.0'
    }

    search_by_title_mock_path = EndpointStitch::stitch(MoviesAPI::Client::SEARCH_BY_TITLE_ENDPOINT) << '&query=Movie%20Title'
    top_rated_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::TOP_RATED_MOVIES_ENDPOINT)

    search_movies_mock_data = MoviesAPIMock::get('search_movie_result.json')
    top_movies_mock_data = MoviesAPIMock::get('top_rated_movies.json')

    stub_request(:get, search_by_title_mock_path).
      with(headers: test_headers).to_return(status: 200, body: search_movies_mock_data, headers: {})

    stub_request(:get, top_rated_movies_mock_path).
      with(headers: test_headers).to_return(status: 200, body: top_movies_mock_data, headers: {})
  end
end
