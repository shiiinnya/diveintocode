class UsersController < ApplicationController
  
  before_action :user_signed, only: [:index, :show]
  
  def index
    @user = User.all
  end

  def show
    @user = User.find params[:id]
  end


private
  def user_params
    params.require(:user).permit(:image)
  end
  
  def user_signed
    redirect_to new_user_session_path unless user_signed_in?
  end
  
end
