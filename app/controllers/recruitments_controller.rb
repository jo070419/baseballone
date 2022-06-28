class RecruitmentsController < ApplicationController

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

  private
  def recruitment_params
    params.require(:recruitment_category).permit(:title, :category_name, :level_id, :capacity_id, :prefecture_id, :ball_park, :event_date, :start_time_id, :end_time_id, :recruitment_deadline, :recruitment_text).merge(user_id: current_user.id)
  end

end
