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
    # movies.each do |movie|
    #   grouped_movies[movie.id] = movie
    # end

    party.users.each do |user|
      user.answers.each do |answer|
        answer_movie = answer.movies.first

        if answer.upped
          movies.each do |movie|
            if movie.id == answer_movie.id
              movie.upped += 1
            end
          end
        end
      end
    end

    movies = movies.any? ? movies : nil

    # render :json => { users: users, movie.to_json(:methods => :upped) }
    # render json: movies.to_json(:methods => :upped)

    render json: movies, methods: :upped
  end
end