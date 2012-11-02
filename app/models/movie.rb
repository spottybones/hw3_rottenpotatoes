class Movie < ActiveRecord::Base

  # class method to return list of all raitings
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  # class method to find all movies that have the director as one passed in
  def self.find_all_by_director_of(movie)
    if not movie.director
      movie.director = ''
    end
    if not movie.director.empty?
      movies = Movie.find_all_by_director(movie.director)
    else
      movies = []
    end
  end
end
