class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @users = User.includes(:access_logs).order("id desc").page(params[:page]).per(200)
    @user_counts = User.select(
      "sum(case when users.device = 'pc' then 1 else 0 end) as pc_count, 
      sum(case when users.device = 'mobile' then 1 else 0 end) as mobile_count, 
      count(*) as total_count")
  end
  
end
