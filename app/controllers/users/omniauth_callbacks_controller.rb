class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    
    # user.rbに記載しているユーザデータを取得する処理を呼び起こす命令
    # ログイン処理
    def facebook
       @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
       @user.skip_confirmation!
        if @user.persisted? 
            set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format? 
            sign_in_and_redirect @user, event: :authentication
        else 
            session["devise.facebook_data"] = request.env["omniauth.auth"] 
            redirect_to new_user_registration_url
        end
    end
    
    def twitter
       @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
       @user.skip_confirmation!
        if @user.persisted? 
         set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format? 
         sign_in_and_redirect @user, event: :authentication
        else 
            session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra") 
            redirect_to new_user_registration_url 
        end
    end
    
end
