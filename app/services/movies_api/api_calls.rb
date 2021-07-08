module ApiCalls
  include Endpoints

  def top_rated_movies
    response = get TOP_RATED_MOVIES_ENDPOINT
    response['results']
  end

  def search_by_title(title)
    response = get SEARCH_BY_TITLE_ENDPOINT, params: {
      query: title
    }
    response['results']
  end

  def trending_movies
    response = get TRENDING_MOVIES_ENDPOINT
    response['results']
  end
end
