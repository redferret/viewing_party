RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, "#{MoviesAPI::Client::API_ENDPOINT}#{MoviesAPI::Client::SEARCH_BY_TITLE_ENDPOINT}?api_key=#{ENV['API_KEY']}&query=Movie%20Title").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.5.0'
        }).to_return(status: 200, body: "", headers: {})
  end
end