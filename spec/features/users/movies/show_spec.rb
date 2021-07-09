require 'rails_helper'

RSpec.describe 'Movies Show page' do
  before :each do
    user = FactoryBot.create(:user)
    login_with(user)

    visit "/movies/0"
  end

  describe 'Show Page' do
    it '' do
      save_and_open_page
      expect(page).to have_content()
    end
  end
end
