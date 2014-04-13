class Pc::HomeController < ApplicationController
  def index
    @user = User.new
    @comments = Comment.published.order(:created_at => :desc).page(params[:page]).per(3)
    @code = '<a href="https://birthday.su-m37.co.kr/?s=blog">
    <img src="http://birthday.su-m37.co.kr/blog_730.jpg"/></a>'
  end
end
