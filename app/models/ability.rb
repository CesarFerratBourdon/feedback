# CanCanCan ability definitions class
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can [:read, :create], Team
      can :read, Feedback
      can :read, Reply
      can :read, Goal
    elsif user.has_role? :manager
      can :read, Team
      can [:read, :create], Feedback
      can [:read, :create, :update], Goal
      can :create, Reply
    elsif user.has_role? :employee
      can :read, Team
      can :read, Feedback
      can [:read, :create, :update], Goal
      can :create, Reply
    end

    # abilities that every user has
    can :create, Invite
  end
end
