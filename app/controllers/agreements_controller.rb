class AgreementsController < ApplicationController
  before_action :authenticate_user!

  def new
    @apply = Apply.find(params[:apply_id])
    @recruitment = Recruitment.find(@apply.recruitment.id)
    message_room = MessageRoom.find_by(apply_id: @apply.id)
    @messages = Message.where(message_room_id: message_room.id).order(id: "DESC")
    @message = Message.new
  end

  def yes
    apply = Apply.find(params[:apply_id])
    agreement = Agreement.new(yes_params(apply))
    unless agreement.save
      render :new, notice: '合意できませんでした'
    end
  end

  def refusal
    apply = Apply.find(params[:apply_id])
    agreement = Agreement.new(refusal_params(apply))
    unless agreement.save
      render :new, notice: 'お断りが完了できませんでした'
    end
  end

  def agreement_recruitment
    @recruitments = Recruitment.where(user_id: current_user.id)
  end

  def agreement_apply
    @applies = Apply.where(user_id: current_user.id)
  end

  def show
    @agreement = Agreement.find(params[:id])
    @message_room = MessageRoom.find_by(apply_id: @agreement.apply_id)
    @messages = Message.where(message_room_id: @message_room.id).order(id: "DESC")
    @message = Message.new
  end

  def cancel_confirmation
    @agreement = Agreement.find(params[:id])
  end

  def cancel_complete
    @agreement = Agreement.find(params[:id])
    @agreement.cancel_flag = true
    @agreement.save
    penalty_point = PenaltyPoint.find_by(user_id: current_user.id)
    add_penalty_point(@agreement, penalty_point)
  end

  private
  def yes_params(apply)
    params.permit(:apply_id).merge(agreement_flag: 1, user_id: apply.user.id, recruitment_id: apply.recruitment.id)
  end

  def refusal_params(apply)
    params.permit(:apply_id).merge(agreement_flag: 0, user_id: apply.user.id, recruitment_id: apply.recruitment.id)
  end

  def add_penalty_point(agreement, penalty_point)
    # 現在の時刻（キャンセルした時の時刻）を入手
    cancel_time = Time.now
    # 募集のイベント開始日を入手
    event_day = agreement.recruitment.event_date
    # 募集の開始時間を入手
    event_time = agreement.recruitment.start_time.name
    # 文字列で入手した募集の開始時間をデータ化
    event_time = Time.parse(event_time)
    # イベント開始日、開始時間をマージ
    event_date = Time.new(event_day.year, event_day.month, event_day.day, event_time.hour, event_time.min, event_time.sec)
    # キャンセル時間とイベント開始時間を計算し、残り時間を算出（時で算出）
    time_left = event_date - cancel_time
    unless time_left == 0
      time_left = time_left/3600
    end
    @penalty_point_log = PenaltyPointLog.new
    # 残り時間に応じてペナルティポイント付与
    if time_left > 48
      penalty_point.point += 2
      penalty_point.save
      @penalty_point_log = PenaltyPointLog.create(increase_decrease_value: 2, penalty_point_id: penalty_point.id)
    elsif time_left > 24
      penalty_point.point += 5
      penalty_point.save
      @penalty_point_log = PenaltyPointLog.create(increase_decrease_value: 5, penalty_point_id: penalty_point.id)
    else 
      penalty_point.point += 8
      penalty_point.save
      @penalty_point_log = PenaltyPointLog.create(increase_decrease_value: 8, penalty_point_id: penalty_point.id)
    end
  end
end
