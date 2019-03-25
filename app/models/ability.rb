class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can :manage, Idea, user_id: user.id
    can :manage, :all if user.has_role? :admin
  end
end
