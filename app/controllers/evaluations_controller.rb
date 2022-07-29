class EvaluationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @evaluation = Evaluation.new
    @agreement = Agreement.find(params[:agreement_id])
  end

  def create
    # 評価相手のユーザーを特定
    agreement = Agreement.find(params[:agreement_id])
    apply = agreement.apply
    message_room = MessageRoom.find_by(apply_id: apply.id)
    entry = Entry.where(message_room_id: message_room.id).where.not(user_id: current_user.id).take
    user = User.find(entry.user.id)
    evaluation = Evaluation.find_by(user_id: user.id)
    evaluate(evaluation)
  end

  def absence_without_notice
    # 評価相手のユーザーを特定
    agreement = Agreement.find(params[:agreement_id])
    apply = agreement.apply
    message_room = MessageRoom.find_by(apply_id: apply.id)
    entry = Entry.where(message_room_id: message_room.id).where.not(user_id: current_user.id).take
    user = User.find(entry.user.id)
    penalty_point = PenaltyPoint.find_by(user_id: user.id)
    penalty_point.point += 10
    penalty_point.save
    penalty_point_log = PenaltyPointLog.create(increase_decrease_value: 10, penalty_point_id: penalty_point.id)
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
