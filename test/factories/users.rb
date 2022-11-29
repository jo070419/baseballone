FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@gmail.com' }
    phone_number          { '080-1000-1000' }
    password              { '000000' }
    password_confirmation { '000000' }

    trait :dup_email do
      phone_number { '090-1000-1000' }
    end

    trait :dup_phone_number do
      email { 'test@au.com' }
    end
  end
end
