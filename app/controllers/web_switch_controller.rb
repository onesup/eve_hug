class WebSwitchController < ApplicationController
  def index
    if request.referer.nil?
      referer = "-"
    else
      referer = URI(request.referer || '').scheme + "://" + URI(request.referer || '').host 
    end
    session[:referer] = request.referer
    Rails.logger.info "@@@@@referer: " + referer
    tracking_id = Rails.application.secrets.ga_tracking_id
    url = Rails.application.secrets.url
    user_agent = UserAgent.parse(request.user_agent)
    source = params[:s] || "-"
    if user_agent.mobile?
      device="mobile"
      @traffic_log = TrafficLog.new
      @traffic_log.ip = request.remote_ip 
      @traffic_log.device = device
      @traffic_log.referer = referer
      @traffic_log.source = source
      @traffic_log.save
      redirect_to mobile_index_path({s: params[:s]})
    else
      device="pc"
      @traffic_log = TrafficLog.new
      @traffic_log.ip = request.remote_ip 
      @traffic_log.device = device
      @traffic_log.referer = referer
      @traffic_log.source = source
      @traffic_log.save
      redirect_to pc_index_path({s: params[:s]})
    end
  end
  
  def event_finish
    finish_time = DateTime.parse("2014-05-15 23:58:00 +0900")
    result = "running"
    result = "finish" if Time.now > finish_time
    respond_to do |format|
      format.json { render json: {result: result}, status: :ok}
    end
  end
end
