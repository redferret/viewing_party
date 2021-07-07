module Helpers
  module Auth
    def login_with(user)
      visit '/'
      within '#login-form' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Login'
      end
    end
  end
end