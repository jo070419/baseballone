class RecruitmentManagementsController < ApplicationController
  def index
    @recruitments = Recruitment.where(user_id: current_user.id)
    @applies = Apply.where(recruitment_id: @recruitments.ids)
  end
end
