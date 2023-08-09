require 'rails_helper'

RSpec.describe MovieParty do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :invitations}
  end

  describe 'model method,' do
    before :each do
      user = create(:user)
      time_date = DateTime.new(2011, 7, 29, 3, 40, 0)
      @movie_party = MovieParty.new(movie_title: 'Test title', movie_poster_path: '/', time_date: time_date)
      user.movie_parties << @movie_party
    end

    describe '#viewing_date' do
      it 'formats the time_date for the view to YYYY-MM-DD' do
        expect(@movie_party.viewing_date).to eq 'View on: 2011-07-29'
      end
    end

    describe '#viewing_time' do
      it 'formats the time_date for the view to HH:MM' do
        expect(@movie_party.viewing_time).to eq 'At: 03:40'
      end
    end
  end
end
