FactoryGirl.define do
  factory :schedule do
    ws 9
    ss 4
  end

  factory :user do
    first_name "John"
    last_name  "Doe"
    sequence(:email) { |n| "#{first_name}.#{last_name + n.to_s}@student.uni-tuebingen.de".downcase }
    password "12345678"
  end

  factory :admin_user, class: User do
    first_name "admin"
    last_name "admin"
    sequence(:email) { |n| "#{first_name}.#{last_name + n.to_s}@student.uni-tuebingen.de".downcase }
    password "12345678"
    after(:create) do |user, evaluator|
      user.make_admin!
    end
  end

  factory :student do
    user
  end

  factory :course_bucket do
    student
  end

  factory :active_course, class: Course do
    sequence(:title) { |n| "Info#{n}" }
    active true
  end

  factory :inactive_course, class: Course do
    sequence(:title) { |n| "Mathe#{n}" }
    active false
  end
end
