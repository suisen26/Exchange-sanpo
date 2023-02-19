class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def index
    @users = User.all
  end

  # def edit
  # end

  # def update
  #   @customer.update(customer_params) ? (redirect_to admin_customer_path(@customer)) : (render :edit)
  # end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
