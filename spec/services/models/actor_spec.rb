require 'rails_helper'

RSpec.describe Models::Actor do
  describe 'instance' do
    before :each do
      @movie = Models::Actor.new({name: 'Edward Norton', character: 'The Narrator'})
    end

    it 'exists' do
      expect(@movie).to be_a Models::Actor
    end

    it 'has a name' do
      expect(@movie.name).to eq 'Edward Norton'
    end

    it 'has a character' do
      expect(@movie.character).to eq 'The Narrator'
    end
  end
end
