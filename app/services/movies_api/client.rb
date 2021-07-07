require_relative 'api_calls'
require_relative 'endpoints'

module MoviesAPI
  class Client
    include Endpoints
    extend ApiCalls

    attr_reader :response

    def self.client(params)
      params[:api_key] = ENV['API_KEY']

      Faraday.new(
        url: API_ENDPOINT,
        params: params
      ) do |faraday|
        faraday.response :logger # log requests and responses to $stdout
      end
    end

    def self.get(endpoint = nil, params: {})
      raise 'API endpoint must be defined' if endpoint.nil?

      @response = client(params).get(endpoint)

      return parse_json if response_successful?

      raise "Status: #{@response.status}, Response: #{@response.body}"
    end

    def self.parse_json
      Oj.load(@response.body)
    end

    def self.response_successful?
      @response.status == 200
    end

    private_class_method :parse_json, :get, :response_successful?
  end
end
