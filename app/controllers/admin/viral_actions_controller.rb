class Admin::ViralActionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @viral_actions = ViralAction.order("id desc").page(params[:page]).per(200)
    @users = User.where("viral_actions_count > 0").order("id desc").page(params[:page]).per(200)
    @viral_action_counts_daily = ViralAction.select(
      "date(convert_tz(viral_actions.created_at,'+00:00','+09:00')) as created_date,
      sum(case when viral_actions.device = 'pc' then 1 else 0 end) as pc_count,
      sum(case when viral_actions.device = 'mobile' then 1 else 0 end) as mobile_count,
      count(*) as total_count")
        .group("date(convert_tz(viral_actions.created_at,'+00:00','+09:00'))")
        .order("date(convert_tz(viral_actions.created_at,'+00:00','+09:00'))")
    @viral_action_counts_sum = ViralAction.select(
      "sum(case when viral_actions.device = 'pc' then 1 else 0 end) as pc_count,
      sum(case when viral_actions.device = 'mobile' then 1 else 0 end) as mobile_count, 
      count(*) as total_count")
    @users_counts_daily = User.select(
      "date(convert_tz(created_at,'+00:00','+09:00')) as created_date,
      sum(case when 
        (users.viral_actions_count > 0) then 1 else 0 end) 
        as pc_count,
      sum(case when 
        (users.viral_actions_count > 0) then 1 else 0 end) 
        as mobile_count,
      sum(case when (users.viral_actions_count > 0) then 1 else 0 end) as total_count")
        .group("date(convert_tz(created_at,'+00:00','+09:00'))")
        .order("date(convert_tz(created_at,'+00:00','+09:00'))")
    @users_counts_sum = User.select(
      "sum(case when (users.viral_actions_count > 0) then 1 else 0 end) as total_count")
  
  end
end
