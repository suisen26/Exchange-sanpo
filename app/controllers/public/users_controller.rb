class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # 他人がユーザーの編集ページ遷移できないようにする 
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
  end
  
  def confirm_withdraw
  end
  
  def withdraw
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
