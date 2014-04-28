class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
   
  def index
    @comments = Comment.all.order('id desc').page(params[:page]).per(200)
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
    comment.status = "deleted"
    comment.save()
    
    redirect_to admin_comments_path
  end
  def set_cherry_picker
    comment = Comment.find(params[:id])
    user = comment.user
    user.status = "cherry_picker"
    user.save
    redirect_to admin_comments_path
  end
end
