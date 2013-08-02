class Ability
  include CanCan::Ability

  def initialize(user)
    if !user
      can :read, :all
    elsif user.admin?
      can :manage, :all
    else
      can :manage, Product, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :manage, Comment do |cmt|
        cmt.product.user.id == user.id
      end 
    end
  end
end
