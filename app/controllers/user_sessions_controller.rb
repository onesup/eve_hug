class UserSessionsController < ApplicationController
  def user_signed_in
    if user_signed_in?
      render json: { result: user_signed_in?, user_id: current_user.id }
    else
      render json: { result: user_signed_in? }
    end
  end
end
