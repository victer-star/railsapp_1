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
