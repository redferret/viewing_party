require_relative '../lib/api_exceptions'
require_relative 'api_calls'

module MoviesAPI
  class Client
    extend ApiExceptions
    extend ApiCalls

    API_ENDPOINT = 'https://api.themoviedb.org/3'.freeze

    attr_reader :response

    def self.client
      @client ||= Faraday.new(API_ENDPOINT) do |client|
        client.headers['Authorization'] = "Bearer #{ENV['MOVIES_API_AUTH_TOKEN']}"
        client.headers['Content-Type'] = 'application/json;charset=utf-8'
      end
    end

    def self.request(http_method: :get, endpoint: nil, params: {})
      raise 'API endpoint must be defined' if endpoint.nil?

      @response = client.public_send(http_method, endpoint, params)

      return parse_json if response_successful?

      raise http_error, "Status: #{response.status}, Response: #{response.body}"
    end

    def self.parse_json
      Oj.load(response.body)
    end

    private_class_method :parse_json, :request
  end
end
