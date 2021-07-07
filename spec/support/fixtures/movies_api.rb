RSpec.configure do |config|
  config.before(:each) do
    test_headers = {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.5.0'
    }

    search_by_title_mock_path = EndpointStitch::stitch(MoviesAPI::Client::SEARCH_BY_TITLE_ENDPOINT) << '&query=Movie%20Title'
    top_rated_movies_mock_path = EndpointStitch::stitch(MoviesAPI::Client::TOP_RATED_MOVIES_ENDPOINT)

    stub_request(:get, search_by_title_mock_path).
      with(headers: test_headers).to_return(status: 200, body: "{\"page\":1,\"results\":[{\"poster_path\":\"/cezWGskPY5x7GaglTTRN4Fugfb8.jpg\",\"adult\":false,
        \"overview\":\"Description\",\"release_date\":\"2012-04-25\",\"genre_ids\":[878,28,12],\"id\":24428,\"original_title\":\"The Avengers\",
        \"original_language\":\"en\",\"title\":\"The Avengers\",\"backdrop_path\":\"/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg\",\"popularity\":7.353212,
        \"vote_count\":8503,\"video\":false,\"vote_average\":7.33}]}", headers: {})

    stub_request(:get, top_rated_movies_mock_path).
      with(headers: test_headers).to_return(status: 200, body: "{\"page\":1,\"results\":[{\"poster_path\":\"/9O7gLzmreU0nGkIB6K3BsJbzvNv.jpg\",\"adult\":false,
        \"overview\":\"Description\",\"release_date\":\"1994-09-10\",\"genre_ids\":[18,80],\"id\":278,\"original_title\":\"The Shawshank Redemption\",
        \"original_language\":\"en\",\"title\":\"The Shawshank Redemption\",\"backdrop_path\":\"/xBKGJQsAIeweesB79KC89FpBrVr.jpg\",\"popularity\":6.741296,
        \"vote_count\":5238,\"video\":false,\"vote_average\":8.32}]}", headers: {})
  end
end
