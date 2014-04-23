class ViralActionsController < ApplicationController
  def create
    @viral_action = ViralAction.new(user_params)
    respond_to do |format|
      
      @log = ViralAction.new(device: params[:viral_action][:device], platform: params[:viral_action][:platform], user_id: params[:viral_action][:user_id])
      @log.save
    
      format.json { render json: {status: "sucess"}, status: :created}
    end
  end
  private
    def user_params
      params.require(:viral_action).permit(:platform, :device, :user_id)
    end
    
    
  
end
