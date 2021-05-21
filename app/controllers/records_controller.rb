class RecordsController < ApplicationController
  before_action :logged_in_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @record = Record.new
    @records = Record.where(user_id: current_user.id).order(start_time: "desc").paginate(page: params[:page], per_page: 5)
  end

  def edit
    @record = Record.find(params[:id])
  end

  def create
    @record = current_user.records.build(records_params)
    if @record.user_id = current_user.id
      @record.save
      flash[:success] = "トレーニングを記録しました"
      redirect_to records_path
    else
      render :index
    end
  end

  def new
    @record = Record.new
  end

  def update
    @record = Record.find(params[:id])
    if @record.update_attributes(records_params)
      flash[:success] = "トレーニング記録を更新しました"
      redirect_to records_path
    else
      render :edit
    end
  end

  def destroy
    @record = Record.find(params[:id])
    if current_user.admin? || current_user?(@training.user)
      @record.destroy
      flash[:success] = "トレーニングを削除しました"
      redirect_to records_path
    else
      flash[:danger] = "他人のトレーニング記録を削除できません"
    end
  end

  private

    def records_params
      params.require(:record).permit(:set, :menu, :start_time, :rep, :weight)
    end

    def ensure_correct_user
      @record = Record.find(params[:id])
      unless @record.user == current_user
        flash[:danger] = 'このページへはアクセスできません。'
        redirect_to records_path
      end
    end
end
