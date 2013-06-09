# -*- encoding : utf-8 -*-

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :administrator
      can :manage, :all
    end

    if user.has_role? :autor
      can :manage, BlogPost, :author_id => user.id
    else
      can :read, BlogPost
    end

    if user.has_role? :spielleiter
      can :manage, Tournament
    end

    if user.has_role? :turnierleiter
      can :manage, Tournament, :referee => user.first_last_name
    end

    if user.has_role? :mannschaftsführer

    end
  end
end
