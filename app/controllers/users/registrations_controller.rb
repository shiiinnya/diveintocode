class Users::RegistrationsController < Devise::RegistrationsController

  before_action :sign_up_parameters, only: [:create]
  before_action :acount_update_parameters, only: [:update]
  
   # user.rbの
   # def self.create_unique_string 
   # SecureRandom.uuid
   #  end
   #メールアドレスをランダムで生成する、TwitterはAPIでメーウアドレスを取得できない
    def build_resource(hash=nil) 
        hash[:uid] = User.create_unique_string
        super # オーバーライド　継承してまたさらに追加する
        # self.resource = resource_class.new_with_session(hash || {}, session)
    end

#　アカウント編集画面でパスワードなしで保存できるようにする
# user.rbの記述を実行する
protected
 def update_resource(resource, params)
     resource.update_without_current_password(params)
 end

  private 
  
def sign_up_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
    u.permit(:image, :name, :username, :email, :password, :password_confirmation)
    end
end
  
  def acount_update_parameters
      devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:image, :name, :username, :email, :password, :password_confirmation)
    end
  end
  
 
end


    
