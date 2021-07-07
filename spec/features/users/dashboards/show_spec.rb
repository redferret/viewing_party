require 'rails_helper'

RSpec.describe 'Dashboard page' do
  before(:each) do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user, email: "email@email.com")
    login_with @user1
    visit '/dashboard'
  end

  it 'has a welcome message' do
    expect(page).to have_content("Welcome #{@user1.email}")
  end

  it 'has sections for freinds and view parties' do
    expect(page).to have_content("Friends")
    expect(page).to have_content("Viewing Parties")
  end

  it 'can search for a friend and add friend' do
    expect(page).to have_field(:email)
    expect(page).to_not have_link('Add Friend')
    expect(page).to have_content("You currently do not have friends")

    fill_in'email', with: "#{@user2.email}"
    click_on("Search")

    expect(page).to have_link('Add Friend')
    click_on("Add Friend")

    within '#flash-message' do
      expect(page).to have_content 'Friend Added!'
    end
  end

  it 'can search for a friend without success' do
    expect(page).to have_field(:email)
    expect(page).to_not have_link('Add Friend')
    expect(page).to have_content("You currently do not have friends")

    fill_in'email', with: "user2@email.com"
    click_on("Search")

    within '#flash-message' do
      expect(page).to have_content 'Sorry! Friend was not found.'
    end
  end

end
