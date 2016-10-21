namespace :reset_rooms do

  desc 'reset rooms which completed booking date'
  task :reset_booked_room => :environment do
    BookedRoom.where('start_time >= ? AND end_time >= ?', DateTime.now, DateTime.now).destroy_all
  end

end