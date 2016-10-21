class HolidaysController < ApplicationController

  before_action :set_holiday, only: [:show, :edit, :update, :destroy]

  def index
    @holidays = Holiday.page(params[:page]).per(8)
  end

  def new
    @holiday = Holiday.new
  end

 def create
  @holiday = Holiday.new(holiday_params)
    respond_to do |format|
      if @holiday.save
        format.html { redirect_to @holiday, notice: 'Holiday was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to @conference_room, notice: 'Holiday was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to conference_rooms_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holiday
      @holiday = Holiday.find(params[:id])
    end

    def holiday_params
      params.require(:holiday).permit(:name, :description, :day)
    end
end
