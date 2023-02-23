class Public::FavoritesController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer, notice; "いいねしました！"
  end
  
  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer, notice: "いいねを外しました。"
  end
  
end
