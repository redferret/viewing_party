require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before :each do
    visit '/'
  end

  describe 'link,' do
    context 'register,' do
      it 'nagivates user to a register page' do
        expect(page).to have_link('New to Viewing Party? Register Here', href: new_register_path)

        click_link 'New to Viewing Party? Register Here'

        expect(current_path).to eq new_register_path
      end
    end

    context 'login,' do
      xit 'logs a user in' do
        within '#login-form' do
          fill_in 'user[email]', with: 'test@test.com'
          fill_in 'user[password]', with: 'password'
          click_link 'Login'
        end

        expect(page).to eq dashboard_path
      end
    end
  end

  describe 'login form,' do
    it 'has an email and password fields' do
      within '#login-form' do
        expect(page).to have_field 'user[email]'
        expect(page).to have_field 'user[password]'
      end
    end
  end
end
