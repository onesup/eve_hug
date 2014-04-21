class UserSessionsController < ApplicationController
  def user_signed_in
    render json: { result: user_signed_in? }
  end
end
