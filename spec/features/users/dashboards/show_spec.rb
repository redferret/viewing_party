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
  end

  describe 'viewing parties section,' do
    it 'has a title' do
      expect(page).to have_content("Viewing Parties")
    end
    
  end
end
