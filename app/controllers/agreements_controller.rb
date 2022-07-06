class AgreementsController < ApplicationController
  def new
    @apply = Apply.find(params[:apply_id])
    @recruitment = Recruitment.find(@apply.recruitment.id)
  end

  def yes
    binding.pry
    apply = Apply.find(params[:apply_id])
    agreement = Agreement.new(yes_params(apply))
    unless agreement.save!
      render :new, notice: '合意できませんでした'
    end
  end

  private
  def yes_params(apply)
    params.permit().merge(agreement_flag: 1, user_id: apply.user.id, recruitment_id: apply.recruitment.id)
  end

end
