class Admin::ChannelsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def index
    @channels = Channel.all
  end
  
  def create
    @channel = Channel.new(channel_params)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to admin_channels_path, notice: 'Channel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @channel }
      else
        format.html { render action: 'new' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    @channel = Channel.find(params[:id])
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to admin_channels_path, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @channel = Channel.find(params[:id])
  end

  def new
    @channel = Channel.new()
  end
   
  private
  def channel_params
    params.require(:channel).permit(:code, :name, :sort_order)
  end
   
end
