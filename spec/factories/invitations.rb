FactoryBot.define do
  factory :invitation do
    movie_party { create(:movie_party) }
    friendship { create(:friendship) }
  end
end
