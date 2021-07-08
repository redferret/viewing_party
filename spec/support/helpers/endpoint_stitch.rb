class EndpointStitch
  def self.stitch(api_endpoint)
    "#{MoviesAPI::Client::API_ENDPOINT}#{api_endpoint}?api_key=#{ENV['API_KEY']}"
  end
end
