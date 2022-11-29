class Recruitment < ApplicationRecord
  belongs_to :user
  has_many   :applies
  has_many   :agreements
  belongs_to :capacity
  belongs_to :end_time
  belongs_to :level
  belongs_to :prefecture
  belongs_to :start_time

  enum category: { opponent: 0, helper: 1 }
  CATEGORYS = Recruitment.categories.keys

  with_options presence: true do
    validates :title,               length: { maximum: 100 }
    validates :category,            inclusion: {in: [CATEGORYS[0], CATEGORYS[1]] }
    validates :level_id,            numericality: { other_than: 1, message: "を入力してください" }
    validates :capacity_id,         numericality: { other_than: 1, message: "を入力してください" }
    validates :prefecture_id,       numericality: { other_than: 1, message: "を入力してください" }
    validates :ball_park,           length: { maximum: 100 }
    validates :event_date
    validates :start_time_id,       numericality: { other_than: 1, message: "を入力してください" }
    validates :end_time_id,         numericality: { other_than: 1, message: "を入力してください" }
    validates :recruitment_deadline
    validates :recruitment_text,    length: { maximum: 1000 }
    validates :user_id
  end
  validate :date_before_start
  validate :date_before_finish

  def date_before_start
    return if event_date.blank?
    errors.add(:event_date, "は今日以降のものを選択してください") if event_date < Date.today.to_s
  end

  def date_before_finish
    return if recruitment_deadline.blank? || event_date.blank?
    errors.add(:recruitment_deadline, "は開始日以前のものを選択してください") if recruitment_deadline > event_date
  end
end
