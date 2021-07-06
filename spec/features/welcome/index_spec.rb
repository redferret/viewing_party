require 'rails_helper'

RSpec.describe 'Welcome Page' do
  it 'has link to admin dashboard' do
      visit '/'

      expect(page).to have_content("Welcome to Viewing Party")
      expect(page).to have_link("New to Viewing Party? Register Here")
  end
end
