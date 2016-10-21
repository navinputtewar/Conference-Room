class UserMailer < ApplicationMailer  

  def booking_confirmation conf_id, user_id
    @user = User.find_by(id: user_id)
    @conference_room = BookedRoom.where(conference_room_id: conf_id).last
    mail(:to => @user.email, from: 'service@conference.com', :subject => 'placed booking')
  end

  def canceling_confirmation
  	@user = User.find_by(id: user_id)
    @conference_room = ConferenceRoom.where(id: conf_id).first
    mail(:to => @user.email, from: 'service@conference.com', :subject => 'Booking cancle')
  end
end
