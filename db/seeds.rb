MODEL = [User, PenaltyPoint, Evaluation, Recruitment]
COUNT = 1..5
MODEL.each do |m|
  m.all.destroy_all
end
COUNT.each do |n|
  User.create(
    nickname:              "test#{n}",
    email:                 "test#{n}@gmail.com",
    password:              "000000",
    password_confirmation: "000000",
    phone_number:          "080#{n}0000000"
  )
  association_user = User.last.id
  PenaltyPoint.create(
    point:   n,
    user_id: association_user
  )
  Evaluation.create(
    good:    n,
    usually: n,
    bad:     n,
    user_id: association_user
  )
  # Recruitment.create(
  #   title: "test#{n}",
  #   level_id: ,
  #   capacity_id: ,
  #   prefecture_id: ,
  #   ball_park: ,
  #   event_date: ,
  #   start_time_id: ,
  #   end_time_id: ,
  #   recruitment_deadline: ,
  #   recruitment_text: ,
  #   user_id: ASSOCIATION_USER,
  #   category_id: 
  # )
end