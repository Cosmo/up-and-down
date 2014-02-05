class PartiesController < ApplicationController
  def index
    if session[:vanity]
      party = Party.where(vanity: session[:vanity]).first
    else
      party = Party.create
      session[:vanity] = party.vanity

      party.questions.create(text: "80s")
      party.questions.create(text: "Tom Hanks")
      party.questions.create(text: "Popular")
    end

    render json: party
  end

  def show
    party = Party.where(vanity: session[:vanity]).first

    render json: { users: party.users, movies: nil }
  end
end