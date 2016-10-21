class DashboardController < ApplicationController
  before_action :authenticate_user!, :except => [:conference_events]
  
  def index
  	#@conference_rooms = ConferenceRoom.page(params[:page]).per(8)
    if params[:search]
      @conference_rooms = ConferenceRoom.tagged_with(params[:search]).page(params[:page]).per(8)
    else
      @conference_rooms = ConferenceRoom.page(params[:page]).per(8)
    end
  end

  def conference_events
    conference_rooms = BookedRoom.all
    respond_to do |format|
	    format.html
	    format.json { render json:conference_rooms.to_json }
	  end

  end

end