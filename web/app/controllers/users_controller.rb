class UsersController < ApplicationController
  def create
    party = Party.where(vanity: params[:party_id]).first

    user = party.users.new
    if params[:name]
      user.name = params[:name]
    else
      user.name = ["Peter", "Heidi", "Manfred", "Sandra"].sample
    end
    user.save

    session[:user_id] = user.id

    party.questions.each do |question|
      question.answers.create(user: user, upped: nil)
    end

    render json: user
  end
end
