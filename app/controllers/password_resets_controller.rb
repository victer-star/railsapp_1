class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワードを再設定するメールを送信しました！"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりません。"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?              # 新しいパスワードが空文字列になっていないか（ユーザー情報の編集ではOKだった）
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)                 # 新しいパスワードが正しければ、更新する
      log_in @user
      flash[:success] = "パスワードの再設定をしました！"
      redirect_to @user
    else
      render 'edit'                                 # 無効なパスワードであれば失敗させる（失敗した理由も表示する）
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

end
