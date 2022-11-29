class RecruitmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]
  before_action :new_recruitment, only: [:new]
  before_action :set_recruitment, only: [:show, :edit, :update]

  def index
    @recruitments = Recruitment.all
  end

  def new; end

  def create
    new_recruitment_params(recruitment_params)
    @recruitment.valid?
    @recruitment.save
  rescue
    render :new
  end

  def edit
    recruitment_attributes = @recruitment.attributes
    new_recruitment_params(recruitment_attributes)
    @recruitment.category_name = @recruitment.category&.category_name
  end

  def show
    @apply = Apply.find_by(recruitment_id: @recruitment.id, user_id: current_user.id)
  end

  def update
    new_recruitment_params(recruitment_params)

    @recruitment.category_name ||= @recruitment.category.category_name

    if @recruitment.valid?
      @recruitment.update(recruitment_params, @recruitment)
    else
      render :edit
    end
  end

  def destroy
    recruitment = Recruitment.find(params[:id])
    unless recruitment.destroy
      render "destroy", notice: '削除できませんでした'
    end
  end

  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :category, :level_id, :capacity_id, :prefecture_id, :ball_park, :event_date, :start_time_id, :end_time_id, :recruitment_deadline, :recruitment_text).merge(user_id: current_user.id)
  end

  def new_recruitment
    @recruitment = Recruitment.new
  end

  def new_recruitment_params(new_params)
    @recruitment = RecruitmentCategory.new(new_params)
  end

  def set_recruitment
    @recruitment = Recruitment.find(params[:id])
  end
end
