class ApplicationController < ActionController::Base
  # Deviseコントローラーを使う前に、configure_permitted_parametersメソッドを呼び出す
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Deviseに受け付けるパラメーターを設定するためのメソッド
  def configure_permitted_parameters
    # nameとintroductionという2つのキーを持つパラメーターを許可するように設定する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction])
  end

end

