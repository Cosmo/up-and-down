class Question < ActiveRecord::Base
  belongs_to :party
  has_many :answers
end
