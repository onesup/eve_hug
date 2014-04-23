class Pc::HomeController < ApplicationController
  def index
    @user = User.new
    @comments = Comment.published.order(:created_at => :desc).page(params[:page]).per(3)
    @comment = Comment.new
  end
end
