class Movies::ShowFacade
  def self.movie_details(id)
    movie_detail = MoviesAPI::Client.movie_details(id)
    cast = movie_detail[:credits][:cast].map do |actor_attrs|
      Poros::Actor.new(actor_attrs)
    end
    reviews = movie_detail[:reviews][:results].map do |movie_review|
      Poros::Review.new(movie_review)
    end
    # binding.pry
    genres = movie_detail[:genres][0..-2].reduce("") do |str, genre|
      str << genre[:name] << ", "
      str
    end
    genres << movie_detail[:genres].last[:name]

    Poros::MovieDetails.new(movie_detail, cast, reviews, genres)
  end
end
