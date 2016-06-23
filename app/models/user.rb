class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  # ここでFacebookやTwitterの情報をとってくる       
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
   
    user = User.create(name: auth.extra.raw_info.name, provider: auth.provider, uid: auth.uid, email: self.create_unique_email, password: Devise.friendly_token[0,20]) 
    # binding.pry
    end 
  user
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil) 
     
    user = User.where(provider: auth.provider, uid: auth.uid).first
    # binding.pry
    unless user
    
    user = User.new(name: auth.info.nickname, provider: auth.provider, uid: auth.uid, email: User.create_unique_email, password: Devise.friendly_token[0,20], username: "http://pbs.twimg.com/profile_images/725732109386551297/tcKXdPof_normal.jpg") 
    user.save
    end 
    user
  end
  
  def self.create_unique_string 
    SecureRandom.uuid
  end
  
  def self.create_unique_email
    User.create_unique_string + "@example.com" 
  end
  
  #　アカウント編集画面でパスワードなしで保存できるようにする
   def update_without_current_password(params, *options)
     params.delete(:current_password)
 
     if params[:password].blank? && params[:password_confirmation].blank?
       params.delete(:password)
       params.delete(:password_confirmation)
     end
 
     result = update_attributes(params, *options)
     clean_up_passwords
     result
   end
  
  has_many :blogs, :dependent => :destroy
  has_many :comments
  has_many :messages
  
  mount_uploader :image, ImageUploader
  
  
end
