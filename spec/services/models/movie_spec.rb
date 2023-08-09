require 'rails_helper'

RSpec.describe Models::Movie do
  describe 'instance' do
    before :each do
      @movie = Models::Movie.new({id: 0, title: 'Test', vote_average: 2})
    end

    it 'exists' do
      expect(@movie).to be_a Models::Movie
    end

    it 'has an id' do
      expect(@movie.id).to eq 0
    end

    it 'has a title' do
      expect(@movie.title).to eq 'Test'
    end

    it 'has a vote average' do
      expect(@movie.vote_average).to eq 2
    end
  end
end