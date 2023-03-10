# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  
  # createアクションの前に、user_stateメソッドを呼び出す
  before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  protected
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  # 退会しているかを判断するメソッド
  def user_state
    # 【処理内容1】入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user
    # 【処理内容2】取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted
      # 【処理内容3】falseの場合、サインインページにリダイレクトする
      redirect_to new_user_session_path, notice: "このユーザーは退会済みです。</br>下記のリンクから、再度会員登録をお願い致します。"
    end
  end
  
end
