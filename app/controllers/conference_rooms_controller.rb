class ConferenceRoomsController < ApplicationController

  before_action :set_conference_room, only: [:show, :edit, :update, :destroy, :book_room, :booked_room, :cancle_booking]
  before_action :set_start_time_end_time, only: [:booked_room]


  def new
    @conference_room = current_user.conference_rooms.new
  end

  def create
    @conference_room = current_user.conference_rooms.new(conference_room_params)
    if @conference_room.save
      redirect_to @conference_room, notice: 'Conference_room was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @conference_room.update(conference_room_params)
      redirect_to @conference_room, notice: 'Conference_room was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @conference_room.destroy
    redirect_to root_path
  end

  def book_room
    @book_room = current_user.booked_rooms.build(:conference_room_id => @conference_room.id)
  end

  def booked_room
    if @conference_room.booked_rooms_records.count >= @conference_room.available_booking
      building_rooms
      redirect_to root_path, alert: "booking closed your request is in wait queue" and return
    else
      if @conference_room.booked_time_slot(@start_time, @end_time).present?
        building_rooms
        redirect_to root_path, alert: 'Conference_room is already booked for given time-slot So your request is in wait queue' and return
      elsif Holiday.where(day: [@start_day,@end_day]).present?
        redirect_to root_path, alert: 'Sorry its a holiday' and return
      end
      book_room = current_user.booked_rooms.build(booked_room_params)
      if book_room.valid?
        book_room.status = 0
        book_room.conference_room_id = params[:id]
        book_room.save
        #RoomBookingJob.perform_later(@conference_room.id, current_user.id)
        redirect_to root_path, notice: 'Conference_room booked successfully' and return
      else
        render :book_room
      end
    end
  end

  def rooms_booked_by_user
    @user_booked_rooms = current_user.booked_conference_rooms.where(status: 0).page(params[:page]).per(8)
  end

  def cancle_booking
    booked_room = current_user.booked_rooms.find_by(id: params[:booked_room_id])
    records = @conference_room.booked_rooms_records.where('(start_time, end_time) overlaps (timestamp :start_time, timestamp :end_time)',:start_time => booked_room.start_time, :end_time => booked_room.end_time)
      booked_room.destroy
      #RoomCancelingJob.perform_later(@conference_room.id, current_user.id)
    if records.present?
      records.first.update_attributes(status: 0)
      redirect_to root_path, notice: "Booking cancle successfully"
    elsif @conference_room.booked_rooms_records.count >= @conference_room.available_booking
      @conference_room.booked_rooms_records.where(status: 2).first.update_attributes(status: 0)
      redirect_to root_path, notice: "Booking cancle successfully"
    else
      render :rooms_booked_by_user, errors: "Something went wrong!!!"
    end
  end

  def building_rooms
    book_room = current_user.booked_rooms.build(booked_room_params)
    book_room.status = 2
    book_room.conference_room_id = params[:id]
    book_room.save
  end

  private

    def set_conference_room
      @conference_room = ConferenceRoom.find(params[:id])
    end

    def conference_room_params
      params.require(:conference_room).permit(:title, :description, :available_booking, :tag_list)
    end

    def booked_room_params
      params.require(:booked_room).permit(:start_time, :end_time, :all_day, :purpose, :status, :conference_room_id)
    end

    def set_start_time_end_time
      @start_time = DateTime.new(params[:booked_room]['start_time(1i)'].to_i, params[:booked_room]['start_time(2i)'].to_i, params[:booked_room]['start_time(3i)'].to_i,  params[:booked_room]['start_time(4i)'].to_i,  params[:booked_room]['start_time(5i)'].to_i)
      @end_time = DateTime.new(params[:booked_room]['end_time(1i)'].to_i, params[:booked_room]['end_time(2i)'].to_i, params[:booked_room]['end_time(3i)'].to_i,  params[:booked_room]['end_time(4i)'].to_i,  params[:booked_room]['end_time(5i)'].to_i)

      @start_day = DateTime.new(params[:booked_room]['start_time(1i)'].to_i, params[:booked_room]['start_time(2i)'].to_i, params[:booked_room]['start_time(3i)'].to_i)

      @end_day = DateTime.new(params[:booked_room]['end_time(1i)'].to_i, params[:booked_room]['end_time(2i)'].to_i, params[:booked_room]['end_time(3i)'].to_i)
    end
end
