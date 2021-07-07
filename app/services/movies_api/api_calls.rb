require_relative 'endpoints'

module ApiCalls
  include Endpoints

  def movie_genres
    get MOVIE_GENRES_ENDPOINT
  end

  def top_rated_movies
    response = get TOP_RATED_MOVIES_ENDPOINT
    response['results']
  end

  def search_by_title(title)
    get SEARCH_BY_TITLE_ENDPOINT, params: {
      query: title
    }
  end
end
