class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    end

    fellowship_category = Organization.categories[user.permission]
    application_category = Application.categories[user.permission]

    if user.moderator?
      can :manage, Organization
    end

    if user.reader? or user.moderator?
      if user.fellowship?
        can :read, Organization
      else
        can :read, Organization, category: fellowship_category
      end
      can :read, Application, category: application_category
      can :read, Choice, organization: { category: fellowship_category }
      can :read, Choice, application: { category: application_category }
    end

    can :destroy, Document, user_id: user.id
    can :manage, Application, user_id: user.id

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
