class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def index
    @posts = Post.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_path, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:text, :post_image, :genre_id)
  end
  
end
