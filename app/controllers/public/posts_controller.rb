class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # 他人が投稿の編集と更新、削除ページに遷移できないようにする
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿の作成に成功しました！"
    else
      render :new
    end
  end


  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿の更新に成功しました！"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user), notice: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:text, :post_image, :genre_id)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

end
