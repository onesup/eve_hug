class ViralActionsController < ApplicationController
  
  def create
    @viral_action = ViralAction.new(viral_action_params)
    @viral_action.save
    respond_to do |format|
      format.json { render json: {status: "sucess"}, status: :created}
    end
  end
  
  private
    def viral_action_params
      params.require(:viral_action).permit(:platform, :device, :user_id)
    end
    
    
  
end
