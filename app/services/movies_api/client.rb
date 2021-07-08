require_relative 'endpoints'
require_relative 'api_calls'

module MoviesAPI
  class Client
    include Endpoints
    extend ApiCalls

    def self.response
      @@response
    end

    def self.client(params)
      params[:api_key] = ENV['API_KEY']

      Faraday.new(
        url: API_ENDPOINT,
        params: params
      )
    end

    def self.get(endpoint = nil, params: {})
      raise 'API endpoint must be defined' if endpoint.nil?

      connection = client(params)
      
      @@response = connection.get(endpoint)

      return parse_json if response_successful?

      raise "Status: #{response.status}, Response: #{response.body}"
    end

    def self.parse_json
      Oj.load(response.body)
    end

    def self.response_successful?
      response.status == 200
    end

    private_class_method :parse_json, :response_successful?, :response
  end
end
