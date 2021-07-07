require 'rails_helper'

RSpec.describe 'Register page' do

  before :each do
    FactoryBot.create(:user)
    visit new_register_path
  end

  describe 'form,' do
    it 'has email and password fields' do
      within 'form' do
        expect(page).to have_field 'user[email]'
        expect(page).to have_field 'user[password]'
        expect(page).to have_button 'Register'
      end
    end
    
    context 'valid registration,' do
      it 'navigates new user to the dashboard' do
        within 'form' do
          fill_in 'user[email]', with: 'test2@test.com'
          fill_in 'user[password]', with: 'password'
          click_button 'Register'
        end

        expect(current_path).to eq dashboard_path

        within '#flash-message' do
          expect(page).to have_content 'Welcome to our app!'
        end
      end
    end

    context 'invalid registration with existing user,' do
      it 'stays on the registration page with a flash alert message' do
        within 'form' do
          fill_in 'user[email]', with: 'test@test.com'
          fill_in 'user[password]', with: 'password'
          click_button 'Register'
        end

        expect(current_path).to eq new_register_path

        within '#flash-message' do
          expect(page).to have_content 'Could not register you'
        end
      end
    end
  end
end
