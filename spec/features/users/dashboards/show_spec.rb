require 'rails_helper'

RSpec.describe 'Dashboard page' do
  before(:each) do
    user_1 = User.create!(email: "user1@email.com", password_digest: "1234")
    visit '/'
    click_on("New to Viewing Party? Register Here")
    within 'form' do
      fill_in 'user[email]', with: 'test2@test.com'
      fill_in 'user[password]', with: 'password'
      click_button 'Register'
    end
  end

  it 'before each section creates user and takes you to dashboard' do
    expect(current_path).to eq("/dashboard")
    # save_and_open_page
  end

  it 'has a welcome message' do
    expect(page).to have_content("Welcome test2@test.com!")
  end

  it 'has sections for freinds and view parties' do
    expect(page).to have_content("Friends")
    expect(page).to have_content("Viewing Parties")
  end

  it 'can search for a friend and add friend' do
    expect(page).to have_field(:email)
    expect(page).to_not have_link('Add Friend')
    expect(page).to have_content("You currently do not have friends")

    fill_in'email', with: "user1@email.com"
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
