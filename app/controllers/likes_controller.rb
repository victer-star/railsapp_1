class LikesController < ApplicationController
  before_action :logged_in_user

  def index
    @all_ranks = Training.create_all_ranks
  end

  def create
    @training = Training.find(params[:training_id])
    @user = @training.user
    current_user.like(@training)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
    # 自分以外のユーザーから作成したトレーニングがいいねがあったときのみ通知を作成
    if @user != current_user
      @user.notifications.create(training_id: @training.id, variety: 3,
                                  from_user_id: current_user.id)
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
    like = Like.find(params[:like_id])
    @training = like.training
    like.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
