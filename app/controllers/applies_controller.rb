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
    message_rooms = MessageRoom.where(recruitment_id: @apply.recruitment.id)
    @messages = Message.where(user_id: current_user.id).or(Message.where(user_id: @apply.recruitment.user.id)).where(message_room_id: message_rooms.ids)
    @message = Message.new
  end

  private
  def apply_params
    params.require(:apply_message).permit(:text).merge(user_id: current_user.id, recruitment_id: params[:recruitment_id])
  end
end
