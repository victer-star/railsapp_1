class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @muscle_items = current_user.muscle.paginate(page: params[:page], per_page: 5)
    end
  end

  def about
  end

  def terms
  end
end
