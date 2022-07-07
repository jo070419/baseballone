class RecruitmentManagementsController < ApplicationController
  before_action :authenticate_user!
  def index
    @recruitments = Recruitment.where(user_id: current_user.id)
  end
end
