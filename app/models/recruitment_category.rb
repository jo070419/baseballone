class RecruitmentCategory

  include ActiveModel::Model
  attr_accessor :title, :level_id, :capacity_id, :prefecture_id, :ball_park, :event_date, :start_time_id, :end_time_id, :recruitment_deadline, :recruitment_text, :user_id, :category_id, :category_name

  with_options presence: true do
    validates :title,               length: {maximum: 100}
    validates :category_name,       inclusion: {in: ["対戦相手","助っ人"] }
    validates :level_id,            numericality: {other_than: 0, message: "can't be blank"}
    validates :capacity_id,         numericality: {other_than: 0, message: "can't be blank"}
    validates :prefecture_id,       numericality: {other_than: 0, message: "can't be blank"}
    validates :ball_park,           length: {maximum: 100}
    validates :event_date
    validates :start_time_id,       numericality: { other_than: 1, message: "can't be blank" }
    validates :end_time_id,         numericality: { other_than: 1, message: "can't be blank" }
    validates :recruitment_deadline
    validates :recruitment_text,    length: {maximum: 1000}
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

  def save
    category = Category.create(category_name: category_name)
    Recruitment.create(title: title, level_id: level_id, capacity_id: capacity_id, prefecture_id: prefecture_id, ball_park: ball_park, event_date: event_date, start_time_id: start_time_id, end_time_id: end_time_id, recruitment_deadline: recruitment_deadline, recruitment_text: recruitment_text, user_id: user_id, category_id: category.id)
  end
end