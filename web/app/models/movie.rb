class Movie < ActiveRecord::Base
  attr_accessor :upped

  has_and_belongs_to_many :questions
  has_and_belongs_to_many :parties
end
