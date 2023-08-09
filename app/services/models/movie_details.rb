module Models
  class MovieDetails
    attr_reader :cast,
                :reviews,
                :title,
                :id,
                :overview,
                :backdrop_path,
                :vote_average,
                :runtime,
                :genres

    def initialize(attrs, cast, reviews, genres)
      @id = attrs[:id]
      @title = attrs[:title]
      @overview = attrs[:overview]
      @backdrop_path = attrs[:backdrop_path]
      @vote_average = attrs[:vote_average]
      @runtime = attrs[:runtime]
      @genres = genres
      @cast = cast
      @reviews = reviews
    end

    def first_10_castmembers
      @cast.first(10)
    end

    def first_five_castmembers
      first_10_castmembers.first(5)
    end

    def last_five_castmembers
      first_10_castmembers.last(5)
    end
  end
end
