# -*- encoding : utf-8 -*-

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :administrator
      can :manage, :all
    elsif user.role? :autor
      can :manage, Blog
    elsif user.role? :spielleiter
      can :manage, Tournament
    elsif user.role? :mannschaftsführer
      can :manage, User
    end
  end
end
