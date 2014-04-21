class Mobile::HomeController < ApplicationController
  layout "mobile"
  def index
    @comments = Comment.published.order(:created_at => :desc).page(params[:page]).per(3)
  end
  
  def thank_you
  
  end
  
  def unique_error
  
  end

  def terms

  end
  def product

  end
end
