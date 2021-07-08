require 'rails_helper'

RSpec.describe Invitation do
  it {should belong_to :movie_party}
  it {should belong_to :friendship}
end
