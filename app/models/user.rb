class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :conference_rooms
  has_many :booked_rooms
  attr_accessor :role

  after_create :set_role


  # def send_devise_notification(notification, *args)
  #   devise_mailer.send(notification, self, *args).deliver_later
  # end

  def set_role
    self.role ? self.add_role(self.role) : self.add_role("Guest")
  end

  def super_manager?
    self.has_role?("super_manager")
  end

  def manager?
    self.has_role?("manager")
  end

  def client?
    self.has_role?("client")
  end

  def guest?
    self.has_role?("guest")
  end

  def booked_conference_rooms
    BookedRoom.where(user_id: self.id)
  end
end
