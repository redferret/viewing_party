require 'rails_helper'

RSpec.describe MoviesAPI::Client do
  describe 'class method,' do
    describe '::client,' do
      it 'returns the instance of a Faraday connection' do
        connection = MoviesAPI::Client.client(params: {})
        expect(connection).to be_a Faraday::Connection
      end
    end

    describe '::get' do
      it 'returns the data from an API call' do
        response = MoviesAPI::Client.get 'test/endpoint'
        results = response[:results]

        expect(response).to be_a Hash
        expect(results).to be_an Array
      end
    end
  end
end
