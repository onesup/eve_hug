class Mobile::CommentsController < ApplicationController
  layout "mobile"
  def new
    @comment = Comment.new
  end
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user    
    respond_to do |format|
      if @comment.save  
        @comment.post
        format.html { redirect_to mobile_thanks_path, notice: 'User was successfully created.' }
        format.json { render json: {status: "success"}, status: :created   }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:message)
    end
end
