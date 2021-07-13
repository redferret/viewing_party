require 'rails_helper'

RSpec.describe Poros::Actor do
  describe 'instance' do
    before :each do
      @movie = Poros::Actor.new({name: 'Edward Norton', character: 'The Narrator'})
    end

    it 'exists' do
      expect(@movie).to be_a Poros::Actor
    end

    it 'has a title' do
      expect(@movie.name).to eq 'Edward Norton'
    end

    it 'has a vote average' do
      expect(@movie.character).to eq 'The Narrator'
    end
  end
end
