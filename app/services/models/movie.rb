module Models
  class Movie
    attr_reader :title, :vote_average, :id

    def initialize(attrs)
      @id = attrs[:id]
      @vote_average = attrs[:vote_average]
      @title = attrs[:title]
    end
  end
end
