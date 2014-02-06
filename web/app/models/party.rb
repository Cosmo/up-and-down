class Party < ActiveRecord::Base
  before_create :generate_vanity

  has_many :users
  has_and_belongs_to_many :movies
  has_many :questions, :through => :movies

  def generate_vanity
    begin
      self.vanity = rand(1111..9999)
    end while self.class.exists?(:vanity => self.vanity)
  end
end