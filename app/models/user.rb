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
   
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def friend
    User.from_users_followed_by(self)
  end
  
  def self.from_users_followed_by(user)
	followed_user_ids = "SELECT X.id FROM (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = :user_id ) X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = :user_id ) Y ON X.id = Y.id"
	where("id IN (#{followed_user_ids})", user_id: user.id)
  end
   
  
  has_many :blogs, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :questions, :dependent => :destroy 
  
  mount_uploader :image, ImageUploader
  
# 第一段階　中間テーブルと関係を定義する
has_many :relationships, foreign_key: "follower_id", dependent: :destroy
has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy

# 第三段階　相対的な参照関係を定義する
has_many :followed_user, through: :relationships, source: :followed
has_many :followes, through: :reverse_relationships, source: :follower
  
  
end
