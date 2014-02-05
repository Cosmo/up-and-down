class QuestionsController < ApplicationController
  before_filter :fetch_user, :only => [:index, :update]

  def index
    render json: @user.answers.where(upped: nil), :include => :question
  end

  def update
    question = @user.answers.where(params[:question_id]).first

    question.update_attributes(:upped => request.body.read)

    render json: question
  end

  def show
    render json: Question.find(params[:id])
  end

  def fetch_user
    @user = User.find(session[:user_id])
  end
end
