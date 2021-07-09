FactoryBot.define do
  factory :movie_party do
    movie_title { Faker::Movie.title }
    movie_poster_path { '/image.png' }
    time_date { '2021-07-20 23:59:59' }
  end
end