require 'rails_helper'

RSpec.describe Models::Review do
  describe 'instance' do
    before :each do
      @movie = Models::Review.new({author: 'Test', content: 'This is my review!'})
    end

    it 'exists' do
      expect(@movie).to be_a Models::Review
    end

    it 'has an author' do
      expect(@movie.author).to eq 'Test'
    end

    it 'displays content' do
      expect(@movie.content).to eq 'This is my review!'
    end
  end
end
