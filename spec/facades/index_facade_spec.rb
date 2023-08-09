require 'rails_helper'

RSpec.describe Movies::IndexFacade do
  describe 'trending_movies' do
    subject { Movies::IndexFacade.trending_movies }

    it 'returns an array of Poros::Movies', :vcr do
      response = subject

      expect(response).to be_an Array
      expect(response.first).to be_a Poros::Movie
    end
  end
end
