class LikesController < ApplicationController
  before_action :logged_in_user

  def index
    @likes = current_user.likes
  end

  def create
    @training = Training.find(params[:training_id])
    @user = @training.user
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @training = Training.find(params[:training_id])
    like = Like.find_by(user_id: @user.id, training_id: @training.id)
    like.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
