class MoviesParties < ActiveRecord::Base
  belongs_to :movie
  belongs_to :party
end
