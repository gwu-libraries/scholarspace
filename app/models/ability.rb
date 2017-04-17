class Ability
  include Hydra::Ability
  include Sufia::Ability


  # Define any customized permissions here.
  def custom_permissions
    # Limits deleting objects to a the admin user
    #
    # if current_user.admin?
    #   can [:destroy], ActiveFedora::Base
    # end

    # Limits creating new objects to a specific group
    #
    # if user_groups.include? 'special_group'
    #   can [:create], ActiveFedora::Base
    # end
    if admin_user?
      can [:create, :show, :add_user, :remove_user, :index, :edit, :update, :destroy], Role
      # CanCan permissions on ContentBlocks are inherited from Sufia::Ability
    end
  end
  
  def generic_file_abilities
    can :view_share_work, [GenericFile]
    can :create, [GenericFile] if admin_user? || contentadmin_user?
  end

  private
  
  def admin_user?
    current_user.admin?
  end
 
  def contentadmin_user?
    current_user.contentadmin?
  end

end
