class MessagesController < ApplicationController
  def apply_show_message
    apply = Apply.find(params[:apply_id])
    message_room = MessageRoom.find_by(recruitment_id: apply.recruitment.id)
    if Message.create(message_params(message_room))
      redirect_to apply_path(apply.id)
    else
      render "applies/show", notice: "メッセージを送信できませんでした"
    end
  end

  def agreement_message
    apply = Apply.find(params[:apply_id])
    message_room = MessageRoom.find_by(recruitment_id: apply.recruitment.id)
    if Message.create(message_params(message_room))
      redirect_to new_apply_agreement_path(apply.id)
    else
      render "agreements/new", notice: "メッセージを送信できませんでした"
    end
  end

  private
  def message_params(message_room)
    params.require(:message).permit(:text).merge(user_id: current_user.id, message_room_id: message_room.id)
  end
end
