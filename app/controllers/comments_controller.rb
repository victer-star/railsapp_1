class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @training = Training.find(params[:training_id])
    @user = @training.user
    @comment = @training.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@training.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @training = @comment.training
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to training_url(@training)
  end
end
