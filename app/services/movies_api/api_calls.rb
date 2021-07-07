module ApiCalls
  def movie_genres
    get '/genre/movie/list'
  end

  def top_rated_movies
    response = get '/movie/top_rated'
    response['results']
  end

  def search_by_title(title)
    get '/search/movie', params: {
      query: title
    }
  end
end
