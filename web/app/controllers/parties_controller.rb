class PartiesController < ApplicationController
  def create
    party = Party.create

    render json: party
  end

  def show
    if params[:id]
      party = Party.where(vanity: params[:id])

      render json: party
    end
  end
end