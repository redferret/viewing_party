RSpec.configure do |config|
  config.before(:each) do
    test_headers = {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.5.0'
    }

    search_by_title_mock_path = EndpointStitch::stitch(MoviesAPI::Client::search_by_title_endpoint) << '&query=Movie%20Title'
    top_rated_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::top_rated_movies_endpoint)
    test_endpoint_path = EndpointStitch::stitch('test/endpoint')
    trending_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::trending_movies_endpoint)
    movie_details_mock_path = EndpointStitch::stitch(MoviesAPI::Client::movie_details_endpoint(0))

    search_movies_mock_data = MoviesAPIMock::get('search_movie_result.json')
    top_movies_mock_data = MoviesAPIMock::get('top_rated_movies.json')
    test_endpoint_data = MoviesAPIMock::get('test_endpoint.json')
    trending_movies_mock_data = MoviesAPIMock::get('trending_movies.json')
    movie_details_mock_data = MoviesAPIMock::get('movie_details.json')

    stub_request(:get, search_by_title_mock_path).
      with(headers: test_headers).to_return(status: 200, body: search_movies_mock_data, headers: {})

    stub_request(:get, top_rated_movies_mock_path).
      with(headers: test_headers).to_return(status: 200, body: top_movies_mock_data, headers: {})

    stub_request(:get, test_endpoint_path).
      with(headers: test_headers).to_return(status: 200, body: test_endpoint_data, headers: {})

    stub_request(:get, trending_movies_mock_path).
      with(headers: test_headers).to_return(status: 200, body: trending_movies_mock_data, headers: {})

    stub_request(:get, movie_details_mock_path).
      with(headers: test_headers).to_return(status: 200, body: movie_details_mock_data, headers: {})
  end
end
