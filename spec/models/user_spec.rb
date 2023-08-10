require 'rails_helper'

RSpec.describe User do
  describe 'validation,' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe "relationships" do
    it { should have_many :friendships }
    it { should have_many :movie_parties }
    it { should have_many(:friends).through(:friendships) }
  end

  describe '#add_friend' do
    subject { user.add_friend(friend) }

    let!(:user) { create(:user, email: 'user1@email.com') }
    let!(:friend) { create(:user, email: 'user2@email.com') }

    it 'adds a friend to this user' do
      subject
      expect(user.friends).to include friend
    end
  end
  
  describe '#remove_friend' do
    it 'removes a friend from this user' do
      user_1 = create(:user, email: "user1@email.com")
      user_2 = create(:user, email: "user2@email.com")
  
      user_1.friends << user_2
      user_1.remove_friend(user_2)

      expect(user_1.friends.include?(user_2)).to eq false
    end
    
    it 'removes any invitations after removing a friend you invited to any party' do
      user_1 = create(:user, email: "user1@email.com")
      user_2 = create(:user, email: "user2@email.com")

      user_2.friends << user_1

      movie_party_1 = create(:movie_party, user: user_2)
      movie_party_2 = create(:movie_party, user: user_2)

      friendship = user_2.friendships.find_by(friend_id: user_1.id)
      Invitation.create(movie_party_id: movie_party_1.id, friendship_id: friendship.id)
      Invitation.create(movie_party_id: movie_party_2.id, friendship_id: friendship.id)

      user_2.remove_friend(user_1)

      expect(user_2.friends.include?(user_1)).to eq false

      invitations = Invitation.find_invitations(user_1.id)

      expect(invitations.empty?).to eq true
    end
  end

  describe '.updated_movie_parties' do
    subject { user.updated_movie_parties }

    let!(:user) { create(:user) }

    context 'when the movie party is in the past' do
      before do
        create(:movie_party, user: user, time_date: DateTime.current - 1.day)
      end

      it 'removes the movie party' do
        expect(user.movie_parties.count).to eq 1
        expect(subject).to eq []
      end
    end

    context 'when the movie party is in the future' do
      before do
        create(:movie_party, user: user, time_date: DateTime.current + 1.day)
      end

      it 'does not remove the movie party' do
        expect(subject).to eq user.movie_parties
      end
    end

    context 'when the movie party is today' do
      before do
        create(:movie_party, user: user, time_date: DateTime.current)
      end

      it 'does not remove the movie party' do
        expect(subject).to eq user.movie_parties
      end
    end
  end
end
