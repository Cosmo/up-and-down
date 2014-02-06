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

    movies = Movie.all

    movies.each do |movie|
      movie.upped = 1
    end

    # movies = {}
    # party.users.each do |user|
    #   user.answers.each do |answer|
    #     movie = answer.movies.first

    #     movies[movie.id] = movie

    #     if answer.upped
    #       movies[movie.id].upped = (movies[movie.id].upped || 0) + 1
    #     end
    #   end
    # end

    movies = movies.any? ? movies : nil

    # render :json => { users: users, movie.to_json(:methods => :upped) }
    # render json: movies.to_json(:methods => :upped)

    render json: movies, methods: :upped
  end
end