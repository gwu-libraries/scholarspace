class User < ActiveRecord::Base
  # Connects this user object to Hydra behaviors.
  include Hydra::User# Connects this user object to Sufia behaviors. 
  include Sufia::User
  include Sufia::UserUsageStats



  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  end

  # Connects this user object to Blacklights Bookmarks. 
  include Blacklight::User
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  if  Rails.env.production?
    devise :database_authenticatable, :trackable, :omniauthable, :omniauth_providers => [:shibboleth]
  else
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
  end
  
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid) || new(uid: auth.uid, provider: auth.provider)
    user.update!(email: auth.info.email,
                 display_name: auth.info.first_name + auth.info.last_name,
                 affiliation: auth.extra.raw_info.affiliation,
		 group_list: auth.extra.raw_info.isMemberOf,
		 :groups_last_update => DateTime.current,
		 :shibboleth_id => auth[:extra][:raw_info][:"Shib-Session-ID"])
    user
  end

#  def self.new_with_session(params, session)
#    super.tap do |user|
#      if data = session["devise.shibboleth_data"] && session["devise.shibboleth_data"]["extra"]["raw_info"]
#        user.email = data["email"] if user.email.blank?
#      end
#    end
#  end

end
