class PartiesController < ApplicationController
  def create
    party = Party.create

    Movie.all.each do |movie|
      party.movies << movie
    end

    render json: party
  end

  def index
    render json: "Works!"
  end

  def show
    party = Party.where(vanity: params[:id]).first
    users = party.users.any? ? party.users : nil

    movies = {}
    party.users.each do |user|
      user.answers.each do |answer|
        movie = answer.movies.first
        
        if movies[movie.id]
          movies[movie.id] = movie
        else
          puts "set"
        end
      end
    end

    # counted_movies = {}
    # movies.each do |movie|
    #   if counted_movie = counted_movies[movie.id]
    #     counted_movie["count"] =+ 1
    #   else
    #     counted_movie = movie
    #     counted_movie["count"] = 1
    #   end
    # end

    render json: { users: users, movies: movies }
  end
end