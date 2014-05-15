class Pc::CommentsController < ApplicationController
  def create
    time = DateTime.parse("2014-05-15 23:58:00 +0900")
    unless Time.now > finish_time
      @comment = Comment.new(comment_params)
      @comment.user = current_user
      device = "pc"
      user_agent = UserAgent.parse(request.user_agent)
      device = "mobile" if user_agent.mobile?
      @comment.device = device
      respond_to do |format|
        if @comment.save  
          @comment.post
          format.html { redirect_to pc_index_path, notice: 'User was successfully created.' }
          format.json { render json: {status: "success"}, status: :created   }
        else
          format.html { render action: 'new' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
    end
  end
private
  def comment_params
    params.require(:comment).permit(:message)
  end
end