class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
   
  def index
    @comments = Comment.all
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.status = "deleted"
    comment.save()
    
    redirect_to admin_comments_path
  end
end
