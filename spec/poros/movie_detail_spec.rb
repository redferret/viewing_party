require 'rails_helper'

RSpec.describe Poros::MovieDetails do
  describe 'instance' do
    before :each do
      @movie = Poros::MovieDetail.new({author: 'Test', content: 'This is my review!'})
    end

    it 'exists' do
      expect(@movie).to be_a Poros::MovieDetail
    end

    it 'has a title' do
      expect(@movie.author).to eq 'Test'
    end

    it 'has a vote average' do
      expect(@movie.content).to eq 'This is my review!'
    end
  end
end
