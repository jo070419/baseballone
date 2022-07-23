class AppliesController < ApplicationController
  before_action :authenticate_user!, only:[:index, :new]

  def new
    @recruitment = Recruitment.find(params[:recruitment_id])
    @apply_message = ApplyMessage.new
  end
  
  def create
    @recruitment = Recruitment.find(params[:recruitment_id])
    @apply_message = ApplyMessage.new(apply_params)
    if @apply_message.valid?
      @apply_message.save
    else
      render :new, notice: '応募に失敗しました'
    end
  end

  def index
    @applies = Apply.where(user_id: current_user.id)
  end

  def show
    @apply = Apply.find(params[:id])
    message_room = MessageRoom.find_by(apply_id: @apply.id)
    @messages = Message.where(message_room_id: message_room.id).order(id: "DESC")
    @message = Message.new
  end

  private
  def apply_params
    params.require(:apply_message).permit(:text).merge(user_id: current_user.id, recruitment_id: params[:recruitment_id])
  end
end
