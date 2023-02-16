class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # 他人がユーザーの編集と更新ページに遷移できないようにする
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザーの更新に成功しました!"
    else
      render :edit
    end
  end

  def confirm_withdraw
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
