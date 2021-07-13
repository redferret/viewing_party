require_relative 'endpoints'

module ApiCalls
  extend Endpoints

  def top_rated_movies
    response = get top_rated_movies_endpoint
    response[:results]
  end

  def search_by_title(title)
    response = get search_by_title_endpoint, params: {
      query: title
    }
    response[:results]
  end

  def trending_movies
    response = get trending_movies_endpoint
    response[:results]
  end

  def movie_details(movie_id)
    get movie_details_endpoint(movie_id), params: {
      append_to_response: 'credits,reviews'
    }
  end

  def upcoming_movies
    response = get upcoming_movies_endpoint
    response[:results]
  end
end
