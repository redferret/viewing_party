class EndpointStitch
  def self.stitch(endpoint)
    "#{MoviesAPI::Client::api_endpoint}#{endpoint}?api_key=#{ENV['API_KEY']}"
  end
end
