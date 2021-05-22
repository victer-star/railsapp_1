class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = current_user.lists
  end

  def create
    @training = Training.find(params[:training_id])
    @user = @training.user
    current_user.list(@training)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @training = list.training
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
