class AddMovieId < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_parties, :movie_id, :string
  end
end
