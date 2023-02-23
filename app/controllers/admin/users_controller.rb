class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def index
    @users = User.all
  end

  def confirm_withdraw
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find_by(email: params[:email])
    @user.update(is_deleted: true)
    reset_session
    redirect_to admin_users_path, notice: "退会させました。"
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end

end
