class RoomBookingJob < ApplicationJob
  queue_as :default

  def perform(conf_id, user_id)
    UserMailer.booking_confirmation(conf_id, user_id).deliver_now
  end
end
