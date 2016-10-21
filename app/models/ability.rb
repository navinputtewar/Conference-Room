class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :manage , ConferenceRoom if user.super_manager?
      can :read, ConferenceRoom if user.manager? || user.client? || user.guest?
    end
  end
end
