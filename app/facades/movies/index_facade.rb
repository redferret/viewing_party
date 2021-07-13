class Movies::IndexFacade
  def self.top_rated_movies
    attrs = MoviesAPI::Client.top_rated_movies
    attrs.map do |movie_result|
      Poros::Movie.new(movie_result)
    end
  end

  def self.trending_movies
    attrs = MoviesAPI::Client.trending_movies
    attrs.map do |movie_result|
      Poros::Movie.new(movie_result)
    end
  end

  def self.upcoming_movies
    attrs = MoviesAPI::Client.upcoming_movies
    attrs.map do |movie_result|
      Poros::Movie.new(movie_result)
    end
  end

  def self.search_by_title(title)
    attrs = MoviesAPI::Client.search_by_title(title)
    attrs.map do |movie_result|
      Poros::Movie.new(movie_result)
    end
  end
end
