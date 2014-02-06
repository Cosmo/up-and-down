class MoviesQuestions < ActiveRecord::Base
  belongs_to :movie
  belongs_to :question
end
