class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path
    end
    @evaluation = Evaluation.find_by(user_id: @user.id)
    @penalty_point = PenaltyPoint.find_by(user_id: @user.id)
  end
end
