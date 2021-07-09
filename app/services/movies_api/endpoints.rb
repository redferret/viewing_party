module Endpoints
  def api_endpoint
    'https://api.themoviedb.org/3/'.freeze
  end

  def top_rated_movies_endpoint
    'movie/top_rated'.freeze
  end

  def search_by_title_endpoint
    'search/movie'.freeze
  end

  def trending_movies_endpoint
    'trending/movie/week'.freeze
  end

  def movie_details_endpoint(movie_id)
    "movie/#{movie_id}".freeze
  end
end
