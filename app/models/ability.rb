class Ability
  include CanCan::Ability
  def initialize(user)
    if user.try(:admin?)
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, Story
      can :manage, User
    end
  end
end