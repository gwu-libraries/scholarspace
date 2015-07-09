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
  end

  def admin_user?
    user_groups.include? 'CN=GWL-SufiaAdmins-GG,OU=Groups,OU=GWL,OU=GWResources,DC=eadtst,DC=gwu,DC=edu'
  end

end
