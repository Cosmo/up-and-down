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
          movies[movie.id].upped += 1
        else
          movies[movie.id] = movie
          movies[movie.id].upped = 1
        end
        
        # if answer.upped
        #   if movies[movie.id] == nil
        #     movies[movie.id] = movie
        #     movies[movie.id].upped = 1
        #   else
        #     movies[movie.id].upped += 1
        #   end
        # end
      end
    end

    # render :json => { users: users, movie.to_json(:methods => :upped) }
    # render json: movies.to_json(:methods => :upped)

    render json: { users: users, movies: movies }
  end
end