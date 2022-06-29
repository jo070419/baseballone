class RecruitmentsController < ApplicationController

  def index
    @recruitments = Recruitment.all
  end

  def new
    @recruitment_category = RecruitmentCategory.new
  end

  def create
    @recruitment_category = RecruitmentCategory.new(recruitment_params)
    if @recruitment_category.valid?
      @recruitment_category.save
    else
      render :new
    end
  end

  def show
    @recruitment = Recruitment.find(params[:id])
  end

  private
  def recruitment_params
    params.require(:recruitment_category).permit(:title, :category_name, :level_id, :capacity_id, :prefecture_id, :ball_park, :event_date, :start_time_id, :end_time_id, :recruitment_deadline, :recruitment_text).merge(user_id: current_user.id)
  end

end
