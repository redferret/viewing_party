require 'rails_helper'

RSpec.describe MoviesService do
  describe 'top_rated_movies' do
    subject { MoviesService.top_rated_movies }

    it 'returns an array of Models::Movies', :vcr do
      response = subject

      expect(response).to be_an Array
      expect(response.first).to be_a Models::Movie
    end

    it 'calls the MoviesAPI::Client.top_rated_movies service' do
      expect(MoviesAPI::Client).to receive(:top_rated_movies).and_return([])
      subject
    end
  end

  describe 'trending_movies' do
    subject { MoviesService.trending_movies }

    it 'returns an array of Models::Movies', :vcr do
      response = subject

      expect(response).to be_an Array
      expect(response.first).to be_a Models::Movie
    end

    it 'calls the MoviesAPI::Client.trending_movies service' do
      expect(MoviesAPI::Client).to receive(:trending_movies).and_return([])
      subject
    end
  end

  describe 'upcoming_movies' do
    subject { MoviesService.upcoming_movies }

    it 'returns an array of Models::Movies', :vcr do
      response = subject

      expect(response).to be_an Array
      expect(response.first).to be_a Models::Movie
    end

    it 'calls the MoviesAPI::Client.upcoming_movies service' do
      expect(MoviesAPI::Client).to receive(:upcoming_movies).and_return([])
      subject
    end
  end

  describe 'search_by_title' do
    subject { MoviesService.search_by_title(title) }

    let(:title) { 'The Matrix' }

    it 'returns an array of Models::Movies', :vcr do
      response = subject

      expect(response).to be_an Array
      expect(response.first).to be_a Models::Movie
    end

    it 'calls the MoviesAPI::Client.search_by_title service' do
      expect(MoviesAPI::Client).to receive(:search_by_title).and_return([])
      subject
    end
  end

  describe 'movie_details' do
    subject { MoviesService.movie_details(movie_id) }

    let(:movie_id) { 684431 }

    it 'returns an array of Models::Movies', :vcr do
      response = subject

      expect(response).to be_a Models::MovieDetails
    end

    it 'calls the MoviesAPI::Client.movie_details service', :vcr do
      expect(MoviesAPI::Client).to receive(:movie_details)
        .and_call_original

      expect(MoviesService).to receive(:build_cast)
        .and_call_original

      expect(MoviesService).to receive(:build_reviews)
        .and_call_original

      expect(MoviesService).to receive(:build_genres)
        .and_call_original

      subject
    end
  end
end
