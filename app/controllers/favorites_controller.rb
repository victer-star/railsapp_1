class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @training = Training.find(params[:training_id])
    @user = @training.user
    current_user.favorite(@training)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
    # 自分以外のユーザーからお気に入り登録があったときのみ通知を作成
    if @user != current_user
      @user.notifications.create(training_id: @training.id, variety: 1,
                                  from_user_id: current_user.id) # お気に入り登録は通知種別1
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
    @training = Training.find(params[:training_id])
    current_user.favorites.find_by(training_id: @training.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def index
    @favorites = current_user.favorites
  end
end
