class CreateMovieParties < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_parties do |t|
      t.belongs_to :user, foreign_key: true
      t.string :movie_title
      t.string :movie_poster_path
      t.datetime :time_date
    end
  end
end
