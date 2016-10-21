class ConferenceRoom < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :facility
  belongs_to :user

  def booked_rooms_records
    BookedRoom.where(conference_room_id: self.id)
  end

  def booked_time_slot start_time, end_time
    self.booked_rooms_records.where('(start_time, end_time) overlaps (timestamp :start_time, timestamp :end_time)',:start_time => start_time, :end_time => end_time)
  end
end
