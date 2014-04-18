class Pc::CommentsController < ApplicationController
  def create
    c = Comment.new(params[:user_params])
    c.save
  end

end