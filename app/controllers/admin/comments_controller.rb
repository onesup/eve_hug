class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
   
  def index
    @comments = Comment.all.order('id desc').page(params[:page]).per(200)
    @comments_counts_daily = Comment.select(
      "date(comments.created_at) as created_date,
      sum(case when comments.device = 'pc' then 1 else 0 end) as pc_count,
      sum(case when comments.device = 'mobile' then 1 else 0 end) as mobile_count,
      count(*) as total_count")
        .group("date(comments.created_at)")
        .order("date(comments.created_at)")
    @comments_counts_sum = Comment.select(
      "sum(case when comments.device = 'pc' then 1 else 0 end) as pc_count,
      sum(case when comments.device = 'mobile' then 1 else 0 end) as mobile_count, 
      count(*) as total_count")
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.status = "deleted"
    comment.save()
    
    redirect_to admin_comments_path
  end
end
