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
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.status = "deleted"
    comment.save()
    
    redirect_to admin_comments_path
  end
end
