require 'rails_helper'

RSpec.describe User do
  describe 'validation,' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe "relationships" do
    it {should have_many :friendships}
    it {should have_many(:friends).through(:friendships)}
  end
end
