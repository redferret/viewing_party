require 'rails_helper'

RSpec.describe User do
  describe 'validation,' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe "relationships" do
    it {should have_many :friendships}
    it {should have_many(:friends).through(:friendships)}
  end

  it 'cand add a friend to a user' do
    user_1 = User.create!(email: "user1@email.com", password_digest: "1234")
    user_2 = User.create!(email: "user2@email.com", password_digest: "1234")
    user_3 = User.create!(email: "user3@email.com", password_digest: "1234")
    user_1.add_friend(user_2)
    result = Friendship.all.first

    expect(result.user_id).to eq(user_1.id)
    expect(result.friend_id).to eq(user_2.id)
    expect(Friendship.all.count).to eq(1)

    user_1.add_friend(user_3)
    result2 = Friendship.all.last

    expect(result2.user_id).to eq(user_1.id)
    expect(result2.friend_id).to eq(user_3.id)
    expect(Friendship.all.count).to eq(2)
  end
end
