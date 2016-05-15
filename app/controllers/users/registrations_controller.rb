class Users::RegistrationsController < Devise::RegistrationsController

  before_action :sign_up_parameters, only: [:create]
  before_action :acount_update_parameters, only: [:update]
  
    def build_resource(hash=nil) 
        hash[:uid] = User.create_unique_string 
        super 
    end
    
protected
 def update_resource(resource, params)
   resource.update_without_current_password(params)
 end

  private 
  
def sign_up_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:image, :name, :email, :password, :password_confirmation)
    end
end
  
  def acount_update_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:image, :name, :email, :password, :password_confirmation)
    end
  end
  
 
end


    
