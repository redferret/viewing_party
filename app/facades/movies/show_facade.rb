class Movies::ShowFacade
  def self.movie_details(id)
    movie_details = MoviesAPI::Client.movie_details(id)
    cast = build_cast(movie_details)
    reviews = build_reviews(movie_details)
    genres = build_genres(movie_details)
    Poros::MovieDetails.new(movie_details, cast, reviews, genres)
  end

  def self.build_cast(movie_details)
    movie_details[:credits][:cast].map do |actor_attrs|
      Poros::Actor.new(actor_attrs)
    end
  end

  def self.build_reviews(movie_details)
    movie_details[:reviews][:results].map do |movie_review|
      Poros::Review.new(movie_review)
    end
  end

  def self.build_genres(movie_details)
    genres = movie_details[:genres][0..-2].reduce('') do |str, genre|
      str << genre[:name] << ', '
      str
    end
    genres << movie_details[:genres].last[:name]
    genres
  end
end
