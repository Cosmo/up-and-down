class Movie < ActiveRecord::Base
  attr_accessor :score

  has_and_belongs_to_many :questions
  has_and_belongs_to_many :parties

  def upped
    score = (score || 0) + 1
  end

  def downed
    score = (score || 0) - 1
  end
end
