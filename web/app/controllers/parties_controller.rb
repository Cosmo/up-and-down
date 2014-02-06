class PartiesController < ApplicationController
  def create
    party = Party.create

    party.questions.create(text: "Biography")
    party.questions.create(text: "Most Popular")
    party.questions.create(text: "Leonardo DiCaprio")
    party.questions.create(text: "Martin Scorsese")
    party.questions.create(text: "Kate Winslet")
    party.questions.create(text: "Romance")
    party.questions.create(text: "90s")
    party.questions.create(text: "Academy Awards nominee")
    party.questions.create(text: "Comedy")
    party.questions.create(text: "Recent Release")

    render json: party
  end

  def show
    party = Party.where(vanity: params[:id]).first

    render json: { users: party.users, movies: nil }
  end
end