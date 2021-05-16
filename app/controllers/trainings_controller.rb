class TrainingsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def index
  end
  
  def new
    @training = Training.new
  end

  def show
    @training = Training.find(params[:id])
    @comment = Comment.new
  end

  def create
    @training = current_user.trainings.build(training_params)
    if @training.save
      flash[:success] = "筋トレメニューが登録されました！"
      redirect_to training_path(@training)
    else
      render 'trainings/new'
    end
  end

  def edit
    @training = Training.find(params[:id])
  end

  def update
    @training = Training.find(params[:id])
    if @training.update_attributes(training_params)
      flash[:success] = "筋トレメニューが更新されました！"
      redirect_to @training
    else
      render 'edit'
    end
  end

  def destroy
    @training = Training.find(params[:id])
    if current_user.admin? || current_user?(@training.user)
      @training.destroy
      flash[:success] = "筋トレメニューが削除されました"
      redirect_to request.referrer == user_url(@training.user) ? user_url(@training.user) : root_url
    else
      flash[:danger] = "他人の筋トレメニューは削除できません"
      redirect_to root_url
    end
  end

  private

    def training_params
      params.require(:training).permit(:name, :description, :tips, :reference, :picture)
    end

    def correct_user
      # 現在のユーザーが更新対象の料理を保有しているかどうか確認
      @training = current_user.trainings.find_by(id: params[:id])
      redirect_to root_url if @training.nil?
    end
end
