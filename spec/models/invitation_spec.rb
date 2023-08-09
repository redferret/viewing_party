require 'rails_helper'

RSpec.describe Invitation do
  describe "relationships" do
    it {should belong_to :movie_party}
    it {should belong_to :friendship}
  end

  it 'can list invitations from a host' do
    @user_1 = create(:user, email: "user1@email.com")
    @user_2 = create(:user, email: "user2@email.com")
    @user_3 = create(:user, email: "user3@email.com")
    @user_4 = create(:user, email: "user4@email.com")
    @user_5 = create(:user, email: "user5@email.com")

    @friendship_1 = Friendship.create!(user: @user_1, friend: @user_2)
    @friendship_2 = Friendship.create!(user: @user_1, friend: @user_3)
    @friendship_3 = Friendship.create!(user: @user_1, friend: @user_5)

    @friendship_4 = Friendship.create!(user: @user_2, friend: @user_1)
    @friendship_5 = Friendship.create!(user: @user_2, friend: @user_3)
    @friendship_6 = Friendship.create!(user: @user_2, friend: @user_4)

    @friendship_7 = Friendship.create!(user: @user_3, friend: @user_5)

    @movie_party = create(:movie_party, user: @user_1)
    @movie_party2 = create(:movie_party, user: @user_2)
    @movie_party3 = create(:movie_party, user: @user_3)

    @invitation_1 = Invitation.create!(movie_party: @movie_party, friendship: @friendship_1)
    @invitation_2 = Invitation.create!(movie_party: @movie_party, friendship: @friendship_2)

    @invitation_3 = Invitation.create!(movie_party: @movie_party2, friendship: @friendship_4)
    @invitation_4 = Invitation.create!(movie_party: @movie_party2, friendship: @friendship_5)
    @invitation_5 = Invitation.create!(movie_party: @movie_party2, friendship: @friendship_6)

    @invitation_6 = Invitation.create!(movie_party: @movie_party3, friendship: @friendship_7)

    expect(Invitation.find_invitations(@user_1.id)[0].id).to eq(@invitation_3.id)
    expect(Invitation.find_invitations(@user_2.id)[0].id).to eq(@invitation_1.id)
    expect(Invitation.find_invitations(@user_3.id)[0].id).to eq(@invitation_2.id)
    expect(Invitation.find_invitations(@user_3.id)[-1].id).to eq(@invitation_4.id)
    expect(Invitation.find_invitations(@user_4.id)[0].id).to eq(@invitation_5.id)
    expect(Invitation.find_invitations(@user_5.id)[0].id).to eq(@invitation_6.id)
  end

end
