class MoviesService
  def self.top_rated_movies
    attrs = MoviesAPI::Client.top_rated_movies
    attrs.map do |movie_result|
      Models::Movie.new(movie_result)
    end
  end

  def self.trending_movies
    attrs = MoviesAPI::Client.trending_movies
    attrs.map do |movie_result|
      Models::Movie.new(movie_result)
    end
  end

  def self.upcoming_movies
    attrs = MoviesAPI::Client.upcoming_movies
    attrs.map do |movie_result|
      Models::Movie.new(movie_result)
    end
  end

  def self.search_by_title(title)
    attrs = MoviesAPI::Client.search_by_title(title)
    attrs.map do |movie_result|
      Models::Movie.new(movie_result)
    end
  end

  def self.movie_details(id)
    movie_details = MoviesAPI::Client.movie_details(id)
    cast = build_cast(movie_details)
    reviews = build_reviews(movie_details)
    genres = build_genres(movie_details)
    Models::MovieDetails.new(movie_details, cast, reviews, genres)
  end

  def self.build_cast(movie_details)
    movie_details[:credits][:cast].map do |actor_attrs|
      Models::Actor.new(actor_attrs)
    end
  end

  def self.build_reviews(movie_details)
    movie_details[:reviews][:results].map do |movie_review|
      Models::Review.new(movie_review)
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
