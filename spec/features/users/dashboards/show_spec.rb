require 'rails_helper'

RSpec.describe 'Dashboard page' do
  before(:each) do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user, email: "email@email.com")
    login_with @user1
    visit dashboard_path
  end

  it 'has a welcome message' do
    within '.welcome_banner' do
      expect(page).to have_content("Welcome #{@user1.email}")
    end
  end

  describe 'adding a friend form,' do
    it 'has a field to find a friend by an email' do
      expect(page).to have_field(:find_friend_by_email)
    end

    it 'has a title' do
      expect(page).to have_content("Friends")
    end

    it 'lets the user know if there are no friends' do
      expect(page).to have_content("You currently do not have friends")
    end

    it 'searched friend can be added to friend list' do
      within '#search-friend-form' do
        fill_in 'find_friend_by_email', with: "#{@user2.email}"
        click_on("Search")
      end

      within '#found-user' do
        expect(page).to have_link('Add Friend')
        click_on("Add Friend")
      end

      within '#flash-message' do
        expect(page).to have_content 'Friend Added!'
      end
    end

    it 'cant add yourself as a friend' do
      within '#search-friend-form' do
        fill_in 'find_friend_by_email', with: "#{@user1.email}"
        click_on("Search")
      end

      within '#found-user' do
        expect(page).to have_link('Add Friend')
        click_on("Add Friend")
      end

      within '#flash-message' do
        expect(page).to have_content "Can't add yourself as a friend"
      end
    end

    it 'cant add the same friend twice' do
      within '#search-friend-form' do
        fill_in 'find_friend_by_email', with: "#{@user2.email}"
        click_on("Search")
      end

      within '#found-user' do
        expect(page).to have_link('Add Friend')
        click_on("Add Friend")
      end

      within '#flash-message' do
        expect(page).to have_content "Friend Added!"
        # save_and_open_page
      end

      within '#search-friend-form' do
        fill_in 'find_friend_by_email', with: "#{@user2.email}"
        click_on("Search")
      end

      within '#found-user' do
        expect(page).to have_link('Add Friend')
        click_on("Add Friend")
      end

      within '#flash-message' do
        expect(page).to have_content 'Friend Already Added'
      end
    end

    it 'can search for a friend without success' do
      within '#search-friend-form' do
        fill_in 'find_friend_by_email', with: "user2@email.com"
        click_on("Search")
      end

      within '#found-user' do
        expect(page).to_not have_link('Add Friend')
      end

      within '#flash-message' do
        expect(page).to have_content 'Sorry! Friend was not found.'
      end
    end

    it 'a friend can be deleted' do
      within '#search-friend-form' do
        fill_in 'find_friend_by_email', with: "#{@user2.email}"
        click_on("Search")
      end

      within '#found-user' do
        expect(page).to have_link('Add Friend')
        click_on("Add Friend")
      end

      within '#flash-message' do
        expect(page).to have_content('Friend Added!')
      end

      expect(page).to have_link('Remove Friend')
      click_on("Remove Friend")
      expect(page).to have_content('Friend Removed')
      expect(page).to_not have_content("@user2.email")
    end
  end

  describe 'viewing parties section,' do
    before(:each) do
      @user_1 = FactoryBot.create(:user, email: "user1@email.com")
      @user_2 = FactoryBot.create(:user, email: "user2@email.com")
      @user_3 = FactoryBot.create(:user, email: "user3@email.com")
      @user_4 = FactoryBot.create(:user, email: "user4@email.com")
      @user_5 = FactoryBot.create(:user, email: "user5@email.com")

      @friendship_1 = Friendship.create!(user: @user_1, friend: @user_2)
      @friendship_2 = Friendship.create!(user: @user_1, friend: @user_3)
      @friendship_3 = Friendship.create!(user: @user_1, friend: @user_5)

      @friendship_4 = Friendship.create!(user: @user_2, friend: @user_1)
      @friendship_5 = Friendship.create!(user: @user_2, friend: @user_3)
      @friendship_6 = Friendship.create!(user: @user_2, friend: @user_4)

      @friendship_7 = Friendship.create!(user: @user_3, friend: @user_5)

      @movie_party = FactoryBot.create(:movie_party, user: @user_1)
      @movie_party2 = FactoryBot.create(:movie_party, user: @user_2)
      @movie_party3 = FactoryBot.create(:movie_party, user: @user_3)

      @invitation_1 = Invitation.create!(movie_party: @movie_party, friendship: @friendship_1)
      @invitation_2 = Invitation.create!(movie_party: @movie_party, friendship: @friendship_2)

      @invitation_3 = Invitation.create!(movie_party: @movie_party2, friendship: @friendship_4)
      @invitation_4 = Invitation.create!(movie_party: @movie_party2, friendship: @friendship_5)
      @invitation_5 = Invitation.create!(movie_party: @movie_party2, friendship: @friendship_6)

      @invitation_6 = Invitation.create!(movie_party: @movie_party3, friendship: @friendship_7)
    end

    it 'has a title' do
      expect(page).to have_content("Movie Parties")
    end

    it 'lists user parties for user 1' do
      login_with @user_1
      visit dashboard_path

      expect(page).to have_content(@movie_party.movie_title)
      expect(page).to have_content(@movie_party2.movie_title)
      expect(page).to_not have_content(@movie_party3.movie_title)
    end
  end
end
