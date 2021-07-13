require 'rails_helper'

RSpec.describe Poros::MovieDetails do
  describe 'instance' do
    before :each do
      @review_1 = ({author: 'Test', content: 'This is my review!'})
      @review_2 = ({author: 'Test Tester', content: 'Great Movie!'})

      @cast_1 = ({name: 'Edward Norton', character: 'The Narrator'})
      @cast_2 = ({name: "Brad Pitt", character: "Tyler Durden"})

      @reviews = [@review_1, @review_2]
      @cast = [@cast_1, @cast_2]

      @attrs = ({title: "Fight Club",
               id: 550,
               overview: "Their concept catches on, with underground 'fight clubs' forming in every town",
               backdrop_path: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
               vote_average: 7.8,
               runtime: 139})

      @genres = {"id": 18, "name": "Drama"}

      @movie = Poros::MovieDetails.new(@attrs, @cast, @reviews, @genres)
    end

    it 'exists' do
      expect(@movie).to be_a Poros::MovieDetails
    end

    it 'had a cast' do
      expect(@movie.cast).to eq([@cast_1, @cast_2])
      expect(@movie.cast.first[:name]).to eq('Edward Norton')
      expect(@movie.cast.last[:character]).to eq("Tyler Durden")
    end

    it 'holds reviews' do
      expect(@movie.reviews).to eq([@review_1, @review_2])
      expect(@movie.reviews.first[:content]).to eq('This is my review!')
      expect(@movie.reviews.last[:author]).to eq('Test Tester')
    end

    it 'holds attrs and its info' do
      expect(@movie.title).to eq("Fight Club")
      expect(@movie.id).to eq(550)
      expect(@movie.overview).to eq("Their concept catches on, with underground 'fight clubs' forming in every town")
      expect(@movie.backdrop_path).to eq("/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg")
      expect(@movie.vote_average).to eq(7.8)
      expect(@movie.runtime).to eq(139)
    end
  end
end
