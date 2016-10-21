class BookedRoom < ApplicationRecord
  belongs_to :conference_room
  belongs_to :user

  enum status: [:booked, :available, :waiting, :cancle]

  def as_json(options = {})
    {
      :id => self.id,
      :title => self.conference_room.try(:title),
      :start => self.start_time,
      :end => self.end_time,
     }
  end

end
