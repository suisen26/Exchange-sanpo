class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:guest_sign_in, :show, :index]
  # 他人がユーザーの編集と更新ページに遷移できないようにする
  before_action :ensure_correct_user, only: [:edit, :update]
  # ゲストユーザーがユーザー編集ページに遷移できないようにする
  before_action :ensure_guest_user, only: [:edit]
  
   # guestメソッドを使用し、ゲストユーザーをログイン状態にする
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "ゲストユーザーでログインしました！"
  end
  
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
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find_by(email: params[:email])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会に成功しました。"
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
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
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストユーザー"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
end
