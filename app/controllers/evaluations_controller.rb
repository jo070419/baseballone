class EvaluationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @evaluation = Evaluation.new
    @agreement = Agreement.find(params[:agreement_id])
  end

  def create
    agreement = Agreement.find(params[:agreement_id])
    apply = agreement.apply
    message_room = MessageRoom.find_by(apply_id: apply.id)
    entry = Entry.where(message_room_id: message_room.id).where.not(user_id: current_user.id).take
    user = User.find(entry.user.id)
    evaluation = Evaluation.find_by(user_id: user.id)
    evaluate(evaluation)
  end

  private

  def evaluate(evaluation)
    if params[:evaluation] == "good"
      evaluation.good += 1
      evaluation.save
    elsif params[:evaluation] == "usually"
      evaluation.usually += 1
      evaluation.save
    else
      evaluation.bad += 1
      evaluation.save
    end
  end
end
