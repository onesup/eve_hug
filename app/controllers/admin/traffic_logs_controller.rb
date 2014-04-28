class Admin::TrafficLogsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def index    
    @traffic_stats = TrafficLog.select(
    "date(convert_tz(created_at,'+00:00','+09:00')) as created_date
    ,sum(case when source='fb' then 1 else 0 end) as home_count
    ,sum(case when source='ts' then 1 else 0 end) as ts_count
    ,sum(case when source='fb_share' then 1 else 0 end) as fb_share_count
    ,sum(case when source='fbad' then 1 else 0 end) as ks_count
    ,sum(case when source not in ('fb', 'ts', 'fb_share' ,'fbad') then 1 else 0 end) as etc_count
    ,count(*) as total_count")
    .group("date(convert_tz(created_at,'+00:00','+09:00'))")
    .order("date(convert_tz(created_at,'+00:00','+09:00'))")
    @traffic_stats_sum = TrafficLog.select("
     sum(case when source='fb' then 1 else 0 end) as home_count
    ,sum(case when source='ts' then 1 else 0 end) as ts_count
    ,sum(case when source='fb_share' then 1 else 0 end) as fb_share_count
    ,sum(case when source='fbad' then 1 else 0 end) as ks_count
    ,sum(case when source not in ('fb', 'ts', 'fb_share' ,'fbad') then 1 else 0 end) as etc_count
    ,count(*) as total_count")
  end
  
  def logs
    def logs
      id = params[:id]
      id = 1 if id.nil?
      @traffic_stats = TrafficLog.paginate_by_week(id)
      @traffic_stats_sum = TrafficLog.paginate_by_week_sum(id)
      @traffic_first_day = TrafficLog.first_day()
    end
  end
end