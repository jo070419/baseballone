class RecruitmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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

  def destroy
    recruitment = Recruitment.find(params[:id])
    unless recruitment.destroy
      render "destroy", notice: '削除できませんでした'
    end
  end
  
  def edit
    @recruitment = Recruitment.find(params[:id])
    recruitment_attributes = @recruitment.attributes
    @recruitment_category = RecruitmentCategory.new(recruitment_attributes)
    @recruitment_category.category_name = @recruitment.category&.category_name
  end

  def update
    @recruitment = Recruitment.find(params[:id])
    @recruitment_category = RecruitmentCategory.new(recruitment_params)

    @recruitment_category.category_name ||= @recruitment.category.category_name

    if @recruitment_category.valid?
      @recruitment_category.update(recruitment_params, @recruitment)
    else
      render :edit
    end
  end

  private
  def recruitment_params
    params.require(:recruitment_category).permit(:title, :category_name, :level_id, :capacity_id, :prefecture_id, :ball_park, :event_date, :start_time_id, :end_time_id, :recruitment_deadline, :recruitment_text).merge(user_id: current_user.id)
  end

end
