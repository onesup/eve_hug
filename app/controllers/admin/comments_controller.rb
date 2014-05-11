class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
   
  def index
    @comments = Comment.includes(:user).order('id desc').page(params[:page]).per(200)
    @comments_counts_daily = Comment.select(
      "date(convert_tz(created_at,'+00:00','+09:00')) as created_date,
      sum(case when 
        (comments.status = 'show' and comments.device = 'pc') then 1 else 0 end) 
        as pc_count,
      sum(case when 
        (comments.status = 'show' and comments.device = 'mobile') then 1 else 0 end) 
        as mobile_count,
      sum(case when comments.status = 'show' then 1 else 0 end) as total_count")
        .group("date(convert_tz(created_at,'+00:00','+09:00'))")
        .order("date(convert_tz(created_at,'+00:00','+09:00'))")
    @comments_counts_sum = Comment.select(
      "sum(case when (comments.status = 'show' and comments.device = 'pc') then 1 else 0 end) 
        as pc_count,
      sum(case when (comments.status = 'show' and comments.device = 'mobile') then 1 else 0 end) 
        as mobile_count, 
      sum(case when comments.status = 'show' then 1 else 0 end) as total_count")
    @users_counts_daily = User.select(
      "date(convert_tz(users.updated_at,'+00:00','+09:00')) as created_date,
      sum(case when 
        (users.comments_count > 0) then 1 else 0 end) 
        as pc_count,
      sum(case when 
        (users.comments_count > 0) then 1 else 0 end) 
        as mobile_count,
      sum(case when (users.comments_count > 0) then 1 else 0 end) as total_count")
        .group("date(convert_tz(users.updated_at,'+00:00','+09:00'))")
        .order("date(convert_tz(users.updated_at,'+00:00','+09:00'))")
    @users_counts_sum = User.select(
      "sum(case when (users.comments_count > 0) then 1 else 0 end) as total_count")
  
  end
  
  def destroy
    comment = Comment.find(params[:id])
    if comment.status =="deleted"
      comment.status = "show"
    else
      comment.status = "deleted"
    end
    
    comment.save()
    
    respond_to do |format|
      format.json { render json: {status: "success", comment_id: comment.id, comment_status: comment.status}   }
    end
    
  end
  def set_cherry_picker
    comment = Comment.find(params[:id])
    user = comment.user
    if user.status == "cherry_picker"
      user.status = ""
    else
      user.status = "cherry_picker"
    end
    user.save
    
    respond_to do |format|
      format.json { render json: {status: "success", user_id: user.id, user_status: user.status}   }
    end
  end
end
