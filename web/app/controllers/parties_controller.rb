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

    grouped_movies = {}

    movies = Movie.all
    movies.each do |movie|
      grouped_movies[movie.id] = movie
    end

    party.users.each do |user|
      user.answers.each do |answer|
        movie = answer.movies.first

        grouped_movies[movie.id] = movie

        if answer.upped == nil
          answer.upped = 1
        else
          answer.upped = answer.upped
        end
      end
    end

    grouped_movies = grouped_movies.any? ? grouped_movies : nil

    # render :json => { users: users, movie.to_json(:methods => :upped) }
    # render json: movies.to_json(:methods => :upped)

    render json: grouped_movies, methods: :upped
  end
end