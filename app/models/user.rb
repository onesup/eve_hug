class User < ActiveRecord::Base
  has_many :access_logs
  has_many :comments
  has_many :authentications
  # validates :agree, acceptance: true
  # validates :agree2, acceptance: true
  # validates :name, presence: true
  # validates :phone, presence: true
  # validates :phone, uniqueness: true
  # validates :birthday, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable # :registerable
  # dragonfly_accessor :last_sign_in_ip
  # image_accessor :last_sign_in_ip
  devise :database_authenticatable, :omniauthable, :omniauth_providers => [:facebook]# , :confirmable 
  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.find_by_email(auth.info.email)
    unless user
      user = User.new( 
        name: auth.extra.raw_info.name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0,20])
    end
    user.token = auth.credentials.token
    # user.remote_avatar_url = user.get_fb_profile_image
    user.save!
    user
  end
  
  def apply_omniauth(auth)
      self.email = auth.extra.raw_info.email
      self.profile_picture = auth.info.image
      self.gender = auth.extra.raw_info.gender
      self.birthday = DateTime.parse(auth.extra.raw_info.birthday)
      self.facebook_url = auth.extra.raw_info.link
      
      authentications.build(
        provider: auth.provider,
        uid: auth.uid, 
        token: auth.extension.token)
      
     
        
    end
    
  def self.fb_username_to_fb_id(username)
    username = username.gsub("https://www.facebook.com","").gsub("https://facebook.com","")
    username = username.gsub("http://www.facebook.com","").gsub("http://facebook.com","")
    oauth = Koala::Facebook::OAuth.new(
      Rails.application.secrets.fb_app_id, Rails.application.secrets.fb_app_secret)
    graph = Koala::Facebook::API.new(oauth.get_app_access_token)
    begin
      graph.get_object(username)["id"]
    rescue
      ""
    end
  end
  
  def get_fb_profile_image
    oauth = Koala::Facebook::OAuth.new(
      Rails.application.secrets.fb_app_id, Rails.application.secrets.fb_app_secret)
    graph = Koala::Facebook::API.new(self.token)
    begin
      graph.get_picture(self.uid,{type: "large"})
    rescue
      ""
    end
  end
end

