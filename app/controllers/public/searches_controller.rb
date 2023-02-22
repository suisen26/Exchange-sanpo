class Public::SearchesController < ApplicationController
  before_action :authenticate_user!, except: [:guest_sign_in, :show, :index]
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    if @model == "User"
      @records = User.search_for(@content, @method)
    else
      @records = Post.search_for(@content, @method)
    end
  end
  
end
