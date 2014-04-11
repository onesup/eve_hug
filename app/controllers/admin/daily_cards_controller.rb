class Admin::DailyCardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def create
    @daily_card = DailyCard.new(daily_card_params)

    respond_to do |format|
      if @daily_card.save
        format.html { redirect_to admin_daily_cards_path, notice: 'DailyCard was successfully created.' }
        format.json { render action: 'show', status: :created, location: @daily_card }
      else
        format.html { render action: 'new' }
        format.json { render json: @daily_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    @daily_card = DailyCard.find(params[:id])
    respond_to do |format|
      if @daily_card.update(daily_card_params)
        format.html { redirect_to admin_daily_cards_path, notice: 'DailyCard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @daily_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    @daily_card.destroy
    respond_to do |format|
      format.html { redirect_to admin_daily_cards_url }
      format.json { head :no_content }
    end
  end
  
  def index
    @daily_cards = DailyCard.all
  end

  def show
  end

  def edit
    @daily_card = DailyCard.find(params[:id])
  end
  

  def new
    @daily_card = DailyCard.new()
  end
  
  private
  def daily_card_params
    params.require(:daily_card).permit(:event_date, :memo, :card_image_pc, :card_image_mobile)
  end
  
end
