class PagesController < ApplicationController
  def index
  end

  def show
  end

  def penalty_point_explanation
  end

  def user_lock
    @user = User.find(current_user.id)
    penalty_point = PenaltyPoint.find_by(user_id: @user.id)
    # 再開までの秒数算出
    days_to_resume = (penalty_point.updated_at + 2592000) - Time.now
    # 小数点以下切り捨て
    days_to_resume.floor
    # 再開までの日数算出
    days_to_resume = days_to_resume / 86400
    # 小数点以下を切り捨て、インスタンス変数に代入
    @days_to_resume = days_to_resume.floor
  end
end
