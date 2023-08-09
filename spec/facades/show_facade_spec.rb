require 'rails_helper'

RSpec.describe Movies::ShowFacade do
  describe 'movie_details' do
    subject { Movies::ShowFacade.movie_details(movie_id) }

    let(:movie_id) { 550 }

    it 'returns an array of Poros::Movies', :vcr do
      expect(subject).to be_a Poros::MovieDetails
    end
  end
end
