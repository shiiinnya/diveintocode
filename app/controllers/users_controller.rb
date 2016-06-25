class UsersController < ApplicationController
  
  before_action :user_signed, only: [:index, :show]
  
  def index
    @user = User.paginate(page:params[:page])
  end

  def show
    @user = User.find params[:id]
  end
  

  def following
    @user = User.find params[:id]
    @users = @user.followed_users
    render "show_follow"
  end
  
  def followers
    @user = User.fond params[:id]
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end
  
private

  def user_signed
    redirect_to new_user_session_path unless user_signed_in?
  end
  
end
