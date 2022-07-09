class AgreementsController < ApplicationController
  before_action :authenticate_user!

  def new
    @apply = Apply.find(params[:apply_id])
    @recruitment = Recruitment.find(@apply.recruitment.id)
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

  def index
    # 自分が応募した情報
    apply = Apply.where(user_id: current_user.id)
    # 自分が出した募集と自分が応募した募集かつ合意した募集
    recruitments = Recruitment.where(user_id: current_user.id).or(Recruitment.where(id: apply.recruitment.ids))
    # 自分が出した募集かつ合意した情報
    @agreements = Agreement.where(recruitment_id: recruitments.ids, agreement_flag: 1)
  end

  private
  def yes_params(apply)
    params.permit().merge(agreement_flag: 1, user_id: apply.user.id, recruitment_id: apply.recruitment.id)
  end

  def refusal_params(apply)
    params.permit().merge(agreement_flag: 0, user_id: apply.user.id, recruitment_id: apply.recruitment.id)
  end
end
