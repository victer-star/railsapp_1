class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  # 検索条件に該当するトレーニングを検索
  def set_search
    if logged_in?
      @search_word = params[:q][:name_cont] if params[:q]
      @q = Training.paginate(page: params[:page], per_page: 5).ransack(params[:q])
      @trainings = @q.result(distinct: true)
    end
  end

  private
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
