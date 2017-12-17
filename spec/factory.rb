FactoryBot.define do

  factory :user do
    email { Faker::Internet.email }
    password '123456'
    password_confirmation '123456'
  end

  factory :task do
    name 'task_name'
    description 'task_description'
    importance 'low'
  end

end