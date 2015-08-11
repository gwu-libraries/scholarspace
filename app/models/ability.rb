class Ability
  include Hydra::Ability
  include Sufia::Ability


  def sufia_abilities
    generic_file_abilities
    user_abilities
    featured_work_abilities
    editor_abilities
    stats_abilities
    citation_abilities
    proxy_deposit_abilities
  end

  def stats_abilities
    alias_action :stats, to: :read
  end

  def citation_abilities
    alias_action :citation, to: :read
  end
  
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
end
