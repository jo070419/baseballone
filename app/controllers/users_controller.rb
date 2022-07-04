class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path
    end
  end
end
