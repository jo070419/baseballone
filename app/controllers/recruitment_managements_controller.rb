class RecruitmentManagementsController < ApplicationController
  def index
    @recruitments = Recruitment.where(user_id: current_user.id)
  end
end
