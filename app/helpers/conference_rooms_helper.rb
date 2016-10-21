module ConferenceRoomsHelper

  def remaining_availability conference_room
    count = conference_room.available_booking - conference_room.booked_rooms_records.count
    count1 = count <= 0 ? 0 : count
    return count1
  end

  def conference_room_data room
    @conference_room = ConferenceRoom.find_by(id: room.conference_room_id)
    @user = User.find_by(id: room.user_id)
  end

  def format_date(date_time)
   Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
