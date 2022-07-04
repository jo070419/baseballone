class AppliesController < ApplicationController
  def new
    @recruitment = Recruitment.find(params[:recruitment_id])
    @apply = Apply.new
  end
  
  def create
    @apply = Apply.new(apply_params)
    unless @apply.save
      render :new, notice: '応募に失敗しました'
    end
  end

  def index
    @applies = Apply.where(user_id: current_user.id)
  end

  private
  def apply_params
    params.permit(:recruitment_id).merge(user_id: current_user.id)
  end
end
