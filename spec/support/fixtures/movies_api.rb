RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, "#{MoviesAPI::Client::API_ENDPOINT}/").
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})
  end
end