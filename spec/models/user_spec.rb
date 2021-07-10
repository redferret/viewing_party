require 'rails_helper'

RSpec.describe User do
  describe 'validation,' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe "relationships" do
    it {should have_many :friendships}
    it {should have_many :movie_parties}
    it {should have_many(:friends).through(:friendships)}
  end

  describe 'model method,' do
    context '#add_friend' do
      it 'adds a friend to this user' do
        user_1 = FactoryBot.create(:user, email: "user1@email.com")
        user_2 = FactoryBot.create(:user, email: "user2@email.com")
    
        user_1.add_friend(user_2)
        result = Friendship.first

        expect(user_1.friends.include?(user_2)).to eq true
      end
    end
    
    context '#remove_friend' do
      it 'removes a friend from this user' do
        user_1 = FactoryBot.create(:user, email: "user1@email.com")
        user_2 = FactoryBot.create(:user, email: "user2@email.com")
    
        user_1.add_friend(user_2)
        user_1.remove_friend(user_2)

        expect(user_1.friends.include?(user_2)).to eq false
      end
    end
  end
end
