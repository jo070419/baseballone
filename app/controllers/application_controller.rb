class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_lock

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :phone_number, { penalty_point_attributes: [:point] }, { evaluation_attributes: [:good, :usually, :bad]}])
  end

  def user_lock
    if signed_in?
      user = User.find(current_user.id)
      penalty_point = PenaltyPoint.find_by(user_id: user.id)
      # 2592000秒 = 30日間
      if penalty_point.point >= 10 && (penalty_point.updated_at + 2592000) < Time.now
        penalty_point.point = 5
        penalty_point.save
        redirect_to root_path
      elsif penalty_point.point >= 10
        redirect_to pages_user_lock_path
      else
      end
    end
  end
end
